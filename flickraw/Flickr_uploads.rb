#-*- coding: utf-8 -*-
require 'flickraw'
require 'rubygems'

def makedir()
u  puts " カレントディレクトリにuploadsフォルダがあるか調べています…"
  if File::exists?("uploads") == false 
    Dir::mkdir("./uploads")
    puts "カレントディレクトリにuploadsディレクトリを作りました"
  else
    puts "確認完了"
  end
end

class MyFlickr < FlickRaw::Flickr

  def initialize
    FlickRaw.api_key ="91e41cb2598e4b43427429ea8d9b3f90"
    FlickRaw.shared_secret = "d244b3372940aab8"
    @flickr = FlickRaw::Flickr.new
    @flickr.access_token = "72157651048798522-3142496243062b65"
    @flickr.access_secret = "81527e86bf0fae75"
  end

  def upload_photos(path = './uploads')
    makedir
    #カレントディレクトリの移動
    Dir.chdir(path)
    p Dir.pwd
    #Dir.globでパターンにマッチするファイル名を文字列の配列として返す File::FNM_CASEFOLDは大文字小文字を区別しないようにするためのもの
    Dir.glob('*.{jpg,jpeg,png}',File::FNM_CASEFOLD).each do |file|
      #例外処理が起こる可能性がある場合
      begin
        #flickrにアップロードする画像がないかどうかを調べる
        photo = @flickr.photos.search(:user_id => '123657572@N03', :text => "#{file}")

        #photoのオブジェクトをto_aで配列に変換し、空か判定する true=>アップロードの開始 false=>すでにアップロードされている
        if photo.to_a.empty? then
          @flickr.upload_photo "#{file}", :title => "#{file}", :is_public => 0, :is_friend => 0, :is_family => 0
          puts "#{Time.now} upload success #{file}"
        else
          puts "#{file} is already uploaded."
        end
        #例外処理が起こった場合
      rescue => ex
        puts "#{Time.now} error"
        puts ex.message
      end
    end
  end
end
