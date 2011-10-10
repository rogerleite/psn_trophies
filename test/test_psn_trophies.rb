require 'rubygems'
require 'bundler/setup'
require 'minitest/autorun'
require 'minitest/spec'
require 'fakeweb'

require 'minitest/reporters'
MiniTest::Unit.runner = MiniTest::SuiteRunner.new
MiniTest::Unit.runner.reporters << MiniTest::Reporters::SpecReporter.new

require 'psn_trophies'

=begin
Tip for getting fixtures:

$ curl -is -e "http://us.playstation.com/publictrophy/index.htm?onlinename=LeiteBR/trophies" "http://us.playstation.com/playstation/psn/profile/LeiteBR/get_ordered_trophies_data" > test/fixtures/success.html 

=end


describe PsnTrophies do

  before { FakeWeb.allow_net_connect = false }
  after  { FakeWeb.allow_net_connect = true }

  describe "valid PSN id" do

    before do
      profile = File.read("test/fixtures/profile_leitebr.html")
      trophies = File.read("test/fixtures/profile_leitebr_trophies.html")

      FakeWeb.register_uri(:get, "http://us.playstation.com/playstation/psn/profiles/LeiteBR", :response => profile)
      FakeWeb.register_uri(:get, "http://us.playstation.com/playstation/psn/profile/LeiteBR/get_ordered_trophies_data", :response => trophies)
    end

    it "should retrieve a list of played games" do
      client = PsnTrophies::Client.new
      played_games = client.trophies("LeiteBR")

      played_games.wont_be_empty
      played_games.first.title.must_equal "Dragon Age II"
    end
  end

  describe "invalid PSN user" do

    before do
      profile = File.read("test/fixtures/profile_nonexistinvaliduser.html")
      FakeWeb.register_uri(:get, "http://us.playstation.com/playstation/psn/profiles/NonExistInvalidUser", :response => profile)
    end

    it "should raise exception" do
      client = PsnTrophies::Client.new
      lambda {
        played_games = client.trophies("NonExistInvalidUser")
      }.must_raise(PsnTrophies::NoUserProfileError)
    end
  end

end
