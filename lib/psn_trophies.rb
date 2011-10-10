require "nokogiri"
require "net/http"
require "uri"

module PsnTrophies

  class Client

    def trophies(profile_id)
      body = get_body("http://us.playstation.com/playstation/psn/profile/#{profile_id}/get_ordered_trophies_data",
                      "http://us.playstation.com/publictrophy/index.htm?onlinename=#{profile_id}/trophies")

      games = []
      doc = Nokogiri::HTML(body)
      doc.css('.slotcontent').each do |container|
        logo = container.at_css('.titlelogo img')["src"]
        title = container.at_css('.gameTitleSortField').content
        progress = container.at_css('.gameProgressSortField').content
        trophies = container.at_css('.gameTrophyCountSortField').content.strip

        games << PlayedGame.new(:image_url => logo, :title => title, :progress => progress, :trophy_count => trophies)
      end
      games
    end

    private

    def get_body(uri, referer)
      uri = URI.parse(uri)
      http = Net::HTTP.new(uri.host, uri.port)

      request = Net::HTTP::Get.new(uri.request_uri)
      request["Host"] = "us.playstation.com"
      request["User-Agent"] = "Mozilla/5.0 (X11; Linux i686; rv:7.0.1) Gecko/20100101 Firefox/7.0.1"
      request["Accept"] = "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8"
      request["Accept-Language"] = "en-us,en;q=0.5"
      request["Accept-Charset"] = "ISO-8859-1,utf-8;q=0.7,*;q=0.7"
      request["Connection"] = "keep-alive"
      request["Referer"] = referer

      response = http.request(request)
      response.body
    end

  end

  class PlayedGame
    attr_accessor :image_url, :title, :progress, :trophy_count

    def initialize(attrs = {})
      attrs.each { |attr, value| self.send(:"#{attr}=", value) }
    end
  end

end
