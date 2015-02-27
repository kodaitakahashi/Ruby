# -*- coding: utf-8 -*-
require 'flickraw'

FlickRaw.api_key="91e41cb2598e4b43427429ea8d9b3f90"
FlickRaw.shared_secret="d244b3372940aab8"

token = flickr.get_request_token
auth_url = flickr.get_authorize_url(token['oauth_token'], :perms => 'delete')

puts "このURLをブラウザで開いて認証プロセスを完了させてください : #{auth_url}"
puts "認証完了後、ブラウザに表示された数字を含む文字列を下にペーストしてください"
verify = gets.strip

begin
  flickr.get_access_token(token['oauth_token'], token['oauth_token_secret'], verify)
  login = flickr.test.login
  puts "認証完了 ユーザ名-> #{login.username} token-> #{flickr.access_token} secret-> #{flickr.access_secret}"
rescue FlickRaw::FailedResponse => e
  puts "認証失敗 : #{e.msg}"
end
