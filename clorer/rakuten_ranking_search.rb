# -*- coding: utf-8 -*-
require 'capybara'
require 'capybara/dsl'
require 'capybara/session'
require 'selenium-webdriver'
require 'anemone'
require 'nokogiri'
require 'kconv'

#初期設定
#ブラウザの設定
Capybara.register_driver :selenium do |app|
  Capybara::Selenium::Driver.new(app,:browser => :chrome)
end
#Rackの起動なし
Capybara.run_server = false
Capybara.current_driver = :selenium
Capybara.app_host = "http://ranking.rakuten.co.jp/"
Capybara.default_wait_time = 2

module Crawler
  class Rakuten_Ranking
    include Capybara::DSL

    def ranking_search(search_word)
      visit('')
      fill_in('stx',:with => search_word)
      click_button "検索"
    end

    def ranking_report
      Anemone.crawl(current_url(),:depth_limit => 0) do |ranking|
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
            puts item.xpath("div[5]").text.gsub(/(\s|　)+/, '')
            #レビュー数
            puts item.xpath("div[6]/div[7]/a").text.gsub(/(\s|　)+/, '')
          }
        end
      end
    end
  end
end
crawler = Crawler::Rakuten_Ranking.new
puts "検索ワードの入力"
search = gets.chop
crawler.ranking_search(search)
crawler.ranking_report
