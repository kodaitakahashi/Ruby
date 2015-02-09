#!/usr/local/bin/ruby

require 'open-uri'
require 'nokogiri'

doc = Nokogiri.HTML(open("http://qa.atmarkit.co.jp/q/2356"))

doc.css('img').each do |element|
  puts element['src']
end
