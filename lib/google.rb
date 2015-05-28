require 'mechanize'
require 'paint'
require "google/version"

module Google

  def self.search
    browser = Mechanize.new

    criteria = ARGV  
    criteria = criteria.join(" ")

    page = browser.get('http://google.com/')  
    form = page.form_with(:name => 'f')
    form.q = criteria
    result = form.submit

    entries = result.search("li.g")

    puts ""
    puts Paint["Results for: #{criteria}", "#006699"]
    puts ""

    entries.each do |entry|
      puts Paint[entry.search("h3.r").text, "#2ECCFA"]
      puts Paint[entry.search("cite").text, "#A9E2F3"]
      puts entry.search("span.st").text
      puts Paint["http://google.com" + entry.search("h3.r").first.children.first.attributes["href"].value, "#045FB4"]
      puts ""
    end

  end
end
