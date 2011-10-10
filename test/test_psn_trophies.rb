require 'rubygems'
require 'bundler/setup'
require 'minitest/autorun'
require 'minitest/spec'

require 'psn_trophies'

describe PsnTrophies do

  describe "valid psn id" do
    it "should be ok" do
      client = PsnTrophies::Client.new
      played_games = client.trophies("LeiteBR")

      played_games.wont_be_empty
      played_games.first.title.must_equal "Dragon Age II"
    end
  end

end
