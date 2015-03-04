#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
# face_detect.rb
require "rubygems"
require "opencv"

include OpenCV

window = GUI::Window.new("face change")
capture = CvCapture.open
detector = CvHaarClassifierCascade::load("./haarcascade_frontalface_alt.xml")
faceimage = IplImage.load './numakuro.jpg'
loop {
  image = capture.query #キャプチャーの問い合わせ
  #顔認識処理
  detector.detect_objects(image).each do |rect|
    #imageを顔検出した犯意に限定
    image.set_roi rect
    resize_faceimage = faceimage.resize rect
    #顔検出された犯意でRGB(f0,f0,f0)以外の時置き換え(透過処理)
    (image.rows * image.cols).times do |j|
      image[j] = resize_faceimage[j] if resize_faceimage[j][0] != 255.0 && resize_faceimage[j][1] != 255.0 && resize_faceimage[j][2] != 255.0
    end
    image.reset_roi
  end

  window.show image
  #終了処理
  berak if GUI::wait_key(100)
}
