require 'open-uri'
require 'nokogiri'
require 'csv'

url = "https://en.wikipedia.org/wiki/List_of_current_NBA_team_rosters"
page = Nokogiri::HTML(open(url))

#for a rough list of teams ==> puts page.css('li.toclevel-3')
#rule of thumb:
  #for class, use a period (.)
  #for id, use hashtag (#)
  #for anything else, use square brackets ([])

#for player names => puts page.css('td[style="text-align:left;"]').text

name = []
page.css('td[style="text-align:left;"]').each do |line|
  #puts line.text
  name << line.text

end

CSV.open("wikitest.csv", "wb") do |file|    #"w" is write, "r" is read, "a" is append
  file << ["Listing Name"]
  name.length.times do |i|
    file << [name[i]]
  end
end

