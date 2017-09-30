require_relative '../../config/environment'

class No_Politics_Scraper::CLI
  
    def call
            print_sources
            choose_sources
        
    end

    def print_sources # needs to be refactored for hash, refactor after news methods are updated
        No_Politics_Scraper::News.sources.each {|key, value| puts "#{key}. #{value}"}
        puts "Choose the number of your source or type 'done'"
    end

    def choose_sources #refactor after print sources are updated
      input = gets.strip 

    if input == "done"
      puts "Now get back to work!"
    else
        while input != "done"
          # if No_Politics_Scraper::News.sources.has_key(input)
          #   hash = No_Politics_Scraper::News.sources
          #   sources = hash[input][1][0]  # or it's a symbol? 
          # end

          if input == "1"
            No_Politics_Scraper::News.scrape_Top_5_Hacker_News
          elsif input == "2"
            No_Politics_Scraper::News.scrape_Top_5_Fox_News
          elsif input == "3"
             No_Politics_Scraper::News.scrape_Top_5_Wall_St_Journal
          else
            puts 'Enter a valid source number'
            choose_sources
          end
          input = gets.strip
      end

      # def print_articles(article_hash)
      #   puts "Use Command Click to Open Article"
      #   article_hash.each do |key, value|
      #     puts key 
      #     puts value
      #   end
      #  # No_Politics_Scraper::CLI.choose_sources
      # end

    end



            #     sources = No_Politics_Scraper::News.sources 
            #         matched_sources = []
            #         sources.each do |source|
            #             if input == source
            #                 matched_sources << source  
            #             end  
            #         end
            #         matched_sources
            #     input = gets.strip.downcase
            #     if matched_sources.include?(input)
            #         print_article(matched_sources)
            #     end
            # end
    end
  

end
