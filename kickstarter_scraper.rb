# require libraries/modules here
require 'nokogiri'
require 'pry'

def create_project_hash
  # this just opens a file and reads it into a variable
  html = File.read('fixtures/kickstarter.html')
  
  # uses Nokogiri's #HTML to parse into nodes
  kickstarter = Nokogiri::HTML(html) 
  
  projects = {}
  
  # iterate through projects 
  kickstarter.css("li.project.grid_4").each do |project|
    title = project.css("h2.bbcard_name strong a").text
    projects[title.to_sym] = {
      :image_link => project.css("div.project-thumbnail a img").attribute("src").value,
      :description => project.css("p.bbcard_blurb").text,
      :location => project.css("span.location-name").text,
      :percent_funded => project.css("ul.project-stats li.first.funded strong").text.gsub("%","").to_i
    }
  end
  projects
end

create_project_hash

# **find selectors and save to be implemented into code!**
# projects: kickstarter.css("li.project.grid_4")
# title: project.css("h2.bbcard_name strong a").text
# image: 
# description: project.css("p.bbcard_blurb").text
# location: project.css("span.location-name").text
# percent_funded: project.css("ul.project-stats li.first.funded strong").text.gsub("%","").to_i