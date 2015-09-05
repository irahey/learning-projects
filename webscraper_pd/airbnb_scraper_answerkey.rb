#Airbnb scraper will scrape entire website base on url search results and save the 
#information in a Excel document

require 'open-uri'
require 'nokogiri'
require 'csv'

#getting input from user
puts "Enter Country"
country = gets.chomp.gsub(' ', '-')
puts "Enter State"
state = gets.chomp.gsub(' ', '-')
puts "Enter City"
city = gets.chomp.gsub(' ', '-')

location = "#{city}--#{state}--#{country}"

#initialize variables
name = []
price = []
description = []
page_numbers = []



url = "https://www.airbnb.com/s/#{location}"
page = Nokogiri::HTML(open(url))

page.css("div.pagination ul li a[target]").each do |page_number|
	page_numbers << page_number.text
end

#gets maximum number of pages for search result
max_page = page_numbers.max.to_i

#loop to iterate through all the pages
(max_page).times do |i|

	url = "https://www.airbnb.com/s/#{location}?page=#{i+1}"
	page = Nokogiri::HTML(open(url))

	page.css('div.h5.listing-name').each do |list_name|
		name << list_name.text.strip
	end

	page.css('span.h3.price-amount').each do |amount|
		price << amount.text
	end

	page.css('div.text-muted.listing-location.text-truncate').each do |line|
		description << line.text.strip.split(/ . /)
	end
end

#writes results in excel file
CSV.open("airbnb_listings.csv", "w") do |file|
	file << ["Listing Name", "Price", "Room Type", "Reviews", "Location"]
	name.length.times do |i|
		file << [name[i], price[i], description[i][0], description[i][1], description[i][2]]
	end
end