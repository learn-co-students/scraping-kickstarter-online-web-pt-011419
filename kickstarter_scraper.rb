# require libraries/modules here
require 'nokogiri'
require 'pry'

def create_project_hash
  projects = {}
  html = File.read('fixtures/kickstarter.html')
  kickstarter = Nokogiri::HTML(html)

  kickstarter.css("li.project.grid_4").each do |element|
    title = element.css("h2.bbcard_name strong a").text
    # image = element.css("div.project-thumbnail a img").attribute("src").value
    # description = element.css("p.bbcard_blurb ").text
    # location = element.css("span.location-name").text
    # percent_funded = element.css("li.first.funded").text.gsub("%", "").to_i
    projects[title.to_sym] = {
      :image_link => element.css("div.project-thumbnail a img").attribute("src").value,
      :description => element.css("p.bbcard_blurb").text,
      :location => element.css("span.location-name").text,
      :percent_funded => element.css("li.first.funded").text.gsub("%", "").to_i
    }
  end
  projects
end
