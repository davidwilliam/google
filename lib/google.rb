require 'mechanize'
require 'paint'
require "google/version"

module Google

  def self.search
    pick_menu
  end

  private

  def self.fetch_results(criteria, count)
    puts "Fetching Google results..."
    browser = Mechanize.new

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
      break if count <= 0
      puts Paint[entry.search("h3.r").text, "#2ECCFA"]
      puts Paint[entry.search("cite").text, "#A9E2F3"]
      puts entry.search("span.st").text
      puts Paint["http://google.com" + entry.search("h3.r").first.children.first.attributes["href"].value, "#045FB4"]
      puts ""
      count -= 1
    end
  end

  def self.show_help
    message = "\n"
    message << "GOOGLE #{VERSION}\n\n"
    message << "NAME\n"
    message << "\tsearch, google\n"
    message << "CRITERIA\n"
    message << "\tKeywords used by the search utility to fetch results from Google’s engine.\n"
    message << "SYNOPSIS\n"
    message << "\tNAME [-v] [-c num] CRITERIA\n"
    message << "OPTIONS\n"
    message << "\t-v\tShow version\n"
    message << "\t-c\tRestrict the number of results\n\n"
    puts message
  end

  def self.show_version
    puts "GOOGLE V#{VERSION}"
  end

  def self.pick_menu
    if ARGV.empty?
      show_help
    else
      count = 10
      options = ARGV.select { |i| i =~ /^-[a-z]{1}/ }

      if options.include? '-v'
        index = ARGV.index '-v'
        ARGV.delete_at index
        show_version
      end

      if options.include? '-c'
        index = ARGV.index '-c'
        begin
          count = ARGV[index + 1]
          count = count.to_i
          ARGV.delete_at(index + 1)
          ARGV.delete_at(index)
        rescue Exception => e
          puts "Wrong argument at -c: #{e.message}"
        end
      end

      fetch_results(ARGV, count)
    end
  end

end