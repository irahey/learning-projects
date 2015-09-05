require 'open-uri'
require 'nokogiri'
require 'csv'

#Initialize variables and store data in arrays. Should be outside of the loop below so it won't empty whenever the loop loops back again.

#Store URL to be scraped
url = "https://www.airbnb.ca/s/Brooklyn--New-York--NY--United-States"

#Parse the page with Nokogiri
page = Nokogiri::HTML(open(url))

#arrays should be outside the loop, else they will empty whenever the loop loops back
name = []
price = []
details = []
page_numbers = []

page.css("div.pagination.pagination-responsive ul.list-unstyled li a[target]").each do |page_number|
  page_numbers << page_number.text.to_i
  
end
#puts page_numbers

#gets maximum number of pages for search result
max_page = page_numbers.max
#puts max_page

#loop to iterate through all the pages
max_page.times do |i|
  #open search results page
  url = "https://www.airbnb.ca/s/Brooklyn--New-York--NY--United-States?page=#{i+1}"
  page = Nokogiri::HTML(open(url))

  page.css('h3.h5.listing-name').each do |line|
    name << line.text.strip
  end
  #puts name

  page.css('span.h3.text-contrast.price-amount').each do |line|
    #puts line.text
    price << line.text
  end

  page.css('div.text-muted.listing-location.text-truncate').each do |line|
    #puts line.text
      subarray = line.text.split(/·/).map(&:strip).reject{ |e| e.empty? } 
    if subarray.length == 2
      details << subarray
    else
      details << [subarray[0], "0 reviews", subarray[1]]
    end
    #details << line.text.split(/·/).map(&:strip).reject{ |e| e.empty? }    #added more code to remove blank entries/cells
  end

  #puts details
  CSV.open("a.csv", "w") do |file|
    file << ["Listing Name", "Price", "Room Type", "Reviews", "Location"]
    name.length.times do |i|
      file << [name[i], price[i], details[i][0], details[i][1], details[i][2]]
    end
  end
end

