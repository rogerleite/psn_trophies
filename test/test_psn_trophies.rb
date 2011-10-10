require 'rubygems'
require 'bundler/setup'
require 'minitest/autorun'
require 'minitest/spec'
require 'fakeweb'
require 'psn_trophies'

=begin
Tip for getting fixtures:

$ curl -is -e "http://us.playstation.com/publictrophy/index.htm?onlinename=LeiteBR/trophies" "http://us.playstation.com/playstation/psn/profile/LeiteBR/get_ordered_trophies_data" > test/fixtures/success.html 

=end


describe PsnTrophies do

  before { FakeWeb.allow_net_connect = false }
  after  { FakeWeb.allow_net_connect = true }

  describe "valid psn id" do

    before do
      success = File.read("test/fixtures/success.html")
      FakeWeb.register_uri(:get, "http://us.playstation.com/playstation/psn/profile/LeiteBR/get_ordered_trophies_data", :response => success)
    end

    it "should be ok" do
      client = PsnTrophies::Client.new
      played_games = client.trophies("LeiteBR")

      played_games.wont_be_empty
      played_games.first.title.must_equal "Dragon Age II"
    end
  end

end
