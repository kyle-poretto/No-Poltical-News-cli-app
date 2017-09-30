require_relative '../../config/environment'
require 'nokogiri'
require 'open-uri'  #had to bc config wasn't working for some reason
require 'pry'

class No_Politics_Scraper::News
    # attr_accessor :headlines, :description, :source, :url

    # @sources = { 
    #     "1. Hacker News" => scrape_Top_5_Hacker_News,
    #     "2. Fox News" => 'hey',
    #     "3. Wall St Journal" => 'scrape_Top_5_Wall_St_Journal'
    #   }
    
    def self.sources
      {
        "1": 'Hacker News',
        "2": 'Fox News',
        "3": 'Wall St. Journal'
      }
    end

    def selected_source(input)
      
    end
    
    # def self.choose_scraper()
    #     @sources.fetch()
    # end

    # refactor to not_political?
    def self.political?(title)
        political_keywords = %w(trump obama maga republicans democrats clinton election nuclear conseratives liberals rep. dems)
        title_words = title.downcase.split(' ') # Take a title and removes the index
        found_political_word = false
        title_words.each do |word|
                    if political_keywords.include?(word)
                        found_political_word = true
                        break
                    end 
                 end
        found_political_word 
    end

    def self.print_articles(article_hash)
        puts "    "
    puts "Use Command Click to Open Article"
    puts "       "
      article_hash.each do |key, value|
        ap key
        puts "            -----#{value}"
      end
    end
     
    def self.scrape_Top_5_Hacker_News
                non_political_headlines = {}
                doc = Nokogiri::HTML(open("https://news.ycombinator.com/"))
                news = self.new
                    doc.css("a.storylink").each do |story|
                        title = story.text
                        if !political?(title) && non_political_headlines.length < 10
                            url_link = story.attribute('href').value                   
                            non_political_headlines.store(story.children.text,url_link)
                        end
                end
            non_political_headlines
            print_articles(non_political_headlines)
     end

    def self.scrape_Top_5_Fox_News
        non_political_headlines = {}
        # {Hacker News => [number, url]}
        doc = Nokogiri::HTML(open("http://www.foxnews.com/"))
        news = self.new
        number = 1
            doc.css("h2.title").attribute('href') do |headline|
                title = headline.text
                        if !political?(title) && non_political_headlines.length < 10
                            url_link = headline.children.attribute('href').value                 
                            non_political_headlines.store(title,url_link)
                        end
                    end
            non_political_headlines
            print_articles(non_political_headlines)
    end


    def self.scrape_Top_5_Wall_St_Journal
            non_political_headlines = {}
            # {Hacker News => [number, url]}
            doc = Nokogiri::HTML(open("https://www.wsj.com/"))
            news = self.new
            number = 1
            doc.css("a.wsj-headline-link").attribute('href') do |headline|
                title = headline.text
                        if !political?(title) && non_political_headlines.length < 10
                            url_link = headline.attribute('href').value                 
                            non_political_headlines.store(title,url_link)
                        end
                    end
            non_political_headlines
            print_articles(non_political_headlines)
        
    end
    


end
