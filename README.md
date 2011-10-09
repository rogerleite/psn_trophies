PsnTrophies
===========

A Ruby API for http://us.playstation.com/psn/trophies
Simply parses html from PSN Public Trophies.

Installation
------------

    gem install psn_trophies

Usage
-----

    require "rubygems"
    require "psn_trophies"
    
    client = PsnTrophies::Client.new
    played_games = client.trophies("psn_id")  # ex. LeiteBR
    played_games.map(&:title)  #=> ["Dragon Age II", "GTA IV", ... etc.]
  
