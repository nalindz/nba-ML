require 'nokogiri'
require 'csv'
require 'open-uri'
require 'json'


links = File.readlines("links.txt")

player_stats = []

links.each do |link|
 link = link.strip!
 break if link.nil?
  doc = Nokogiri::HTML(open(link))

  puts link

  player_stat = {}
  player_stat['points'] = doc.css(".stat_total")[0].css('td').last.text
  player_stat['rebounds'] = doc.css(".stat_total")[0].css('td')[19].text
  player_stat['assists'] = doc.css(".stat_total")[0].css('td')[20].text
  player_stat['steals'] = doc.css(".stat_total")[0].css('td')[21].text
  player_stat['blocks'] = doc.css(".stat_total")[0].css('td')[22].text
  player_stat['3pts'] = doc.css(".stat_total")[0].css('td')[11].text
#  player_stat['name'] = doc.css("h1")[0].text

  begin
#    player_stat['position'] = doc.css("p")[3].text.split(':')[1].split("\u25AA")[0].strip!
  rescue
#    player_stat['position'] = doc.css("p")[4].text.split(':')[1].split("\u25AA")[0].strip!
  end

  begin
    player_stat['height'] = doc.css("p")[3].text.split(':')[3].split("\u25AA")[0].strip!
  rescue
    player_stat['height'] = doc.css("p")[4].text.split(':')[3].split("\u25AA")[0].strip!
  end

  player_stat['num_championships'] = 0
  player_stat['num_all_star_games'] = 0
  doc.css(".margin_bottom").each do |a|
    championships_text = a.text.split('Championships(Minimum 1 playoff game)')
    if championships_text.length > 1
      player_stat['num_championships'] = championships_text[1].split('(NBA)').count 
    end
  end

  doc.css(".margin_bottom").each do |a|
    allstar_text = a.text.split('All-Star Games')

    if allstar_text.length > 1
      player_stat['num_all_star_games'] = allstar_text[1].split('NBA').count
    end
  end
  player_stats << player_stat
end

player_stat_out = player_stats.map { |a| a.values }
puts player_stat_out.to_json



#CSV.open("stats.csv", "wb") do |csv|
#  csv << player_stats.first.keys
#  player_stats.each do |stat|
#    csv <<  stat.values
#  end
#end
#
