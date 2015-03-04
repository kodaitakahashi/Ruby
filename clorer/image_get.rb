# -*- coding: utf-8 -*-
require 'google-search'
class Google_search
  LIMIT_MAX = 5
  def initialize
    @get_uri = []
  end
  
  def get_uri(search_word,limit=LIMIT_MAX)
    Google::Search::Web.new(:query => search_word).each do |item|
      @get_uri.push(item.uri)
    end
  end
  
  def get_uri_image(search_word,limit=LIMIT_MAX)
    Google::Search::Image.new(:query => search_word).each do |item|
      @get_uri.push(item.uri)
      puts @get_uri
    end
  end
end

get = Google_search.new
get.get_uri_image("アヘ顔")
