#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
# color_jug.rb
require "rubygems"
require "opencv"

include OpenCV

window = GUI::Window.new("color_jug")


faceimage = IplImage::load './jonouchi.jpg'
color_HSV = faceimage.Luv2RGB

Window.show(color_HSV)
GUI::wait_key

