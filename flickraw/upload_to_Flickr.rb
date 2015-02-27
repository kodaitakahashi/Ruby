#-*- coding: utf-8 -*-
require 'rubygems'
require 'flickraw'

#ロードパスにカレントディレクトを追加
$:.unshift File.dirname(__FILE__)
require './Flickr_uploads.rb'

myflickr_uploads = MyFlickr.new
myflickr_uploads.upload_photos
