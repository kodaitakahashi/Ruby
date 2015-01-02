#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
# face_detect.rb
require "rubygems"
require "opencv"

include OpenCV

window = GUI::Window.new("face detect")
capture = CvCapture.open
detector = CvHaarClassifierCascade::load("./haarcascade_frontalface_alt.xml")
loop {
  image = capture.query #キャプチャーの問い合わせ
  #顔認識処理
  detector.detect_objects(image).each { |rect|
    image.rectangle! rect.top_left, rect.bottom_right, :color => CvColor::Green
  } #rectに顔として検出したいimgに処理をする
  window.show image
  #終了処理
  berak if GUI::wait_key(100)
}
