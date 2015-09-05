require 'open-uri'
require 'nokogiri'
require 'csv'

#Store URL to be scraped
url = "https://www.airbnb.ca/s/Brooklyn--New-York--NY--United-States"

#Parse the page with Nokogiri
page = Nokogiri::HTML(open(url))

#Display output onto the screen
#puts page.css('div.h5.listing-name')
#puts page.css('span.h3.price-amount')

#Store data in rrays
name = []
page.css('h3.h5.listing-name').each do |line|
  #puts line.text  #Display output onto the screen
  name << line.text.strip
end
puts 
#puts name
price = []
page.css('span.h3.text-contrast,price-amount').each do |line|
  #puts line.text
  price << line.text
end

details = []
page.css('div.text-muted.listing-location.text-truncate').each do |line|
  #puts line.text
  details << line.text.split(/·/).map(&:strip).reject{ |e| e.empty? }    #added more code to remove blank entries
end

#puts details
CSV.open("airbnb_listings.csv", "w") do |file|
	file << ["Listing Name", "Price", "Room Type", "Reviews", "Location"]

	name.length.times do |i|
		file << [name[i], price[i], details[i][0], details[i][1], details[i][2]]
	end
end


