# -*- coding: utf-8 -*-
require 'capybara'
require 'capybara/dsl'
require 'capybara/session'
require 'selenium-webdriver'
require 'anemone'
require 'nokogiri'
require 'kconv'
url = "http://ranking.rakuten.co.jp/search?stx=%E3%83%A8%E3%83%BC%E3%82%B0%E3%83%AB%E3%83%88&prl=&pru=&rvf=&arf=&vmd=0&ptn=1&srt=1&sgid=214120"
Anemone.crawl(url,:depth_limit => 0) do |ranking|
  ranking.on_every_page do |page|
    doc = Nokogiri::HTML.parse(page.body.toutf8)
    items =  doc.xpath("//*[@class=\"waku1\"]/div")
    items.each{|item|
      #順位
      puts item.xpath("div[1]/span").text.gsub(/(\s|　)+/, '')
      #カテゴリ
      puts "カテゴリ"+item.xpath("div[2]/a").text.gsub(/(\s|　)+/, '')
      #商品名
      puts item.xpath("div[4]/a").text.gsub(/(\s|　)+/, '')
      #値段
      puts item.xpath("div[5]").textgsub(/(\s|　)+/, '')
      #レビュー数
      puts item.xpath("div[6]/div[7]/a").text.gsub(/(\s|　)+/, '')
    }
  end
end
