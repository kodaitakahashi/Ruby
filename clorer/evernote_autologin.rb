# -*- coding: utf-8 -*-
require 'capybara'
require 'capybara/dsl'
require 'selenium-webdriver'

#初期設定
#起動ブラウザをchromeに変更
Capybara.register_driver :selenium do |app|
  Capybara::Selenium::Driver.new(app,:browser => :chrome)
end
#デフォルトではRackアプリケーションの起動するため起動させないようにfalseに設定
Capybara.run_server = false 
#デフォルトは:racj_testのため、JavaScriptの実行や外部のHTTP通信などができないため:seleniumnに設定
Capybara.current_driver = :selenium
#対象サイトのURLを設定
Capybara.app_host = "https://www.evernote.com/Login.action?targetUrl=%2FHome.action#st=p&n=15e091d5-4c72-4b7c-8976-ad243371a790"
#待ち時間
Capybara.default_wait_time = 10

module Crawler
  class Evernote
    include Capybara::DSL
    
    def login
      visit('')
      fill_in "username", :with => '*********'
      fill_in "password", :with => '*********'
      click_button "login"
    end
  end
end

crawler = Crawler::Evernote.new
crawler.login
