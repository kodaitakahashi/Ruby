# -*- coding: utf-8 -*-
require 'opencv'
include OpenCV

img_count =0
#分類器の指定
detector = CvHaarClassifierCascade::load '/usr/local/Cellar/opencv/2.4.9/share/OpenCV/haarcascades/haarcascade_frontalface_alt.xml'
#カレントディレクトの移動
begin
  Dir.chdir('./img')
rescue => ex
  puts "フォルダ移動失敗"
  puts ex.message
end
#カレントディレクトで該当するすべてのファイルを対象にする
Dir.glob('*.{jpg,jpeg,png}',File::FNM_CASEFOLD).each do |filename|
  puts"ファイルあり"
  begin
    image = IplImage.load(filename)
    puts("ファイル読み込み成功")
    #imageをグレースケールに変換
    grayimage=image.BGR2GRAY
    #grayimageをヒストグラムの均一化にする
    grayimage_equalize_hist = grayimage.equalize_hist
    Dir.chdir("../result")
  rescue => ex
    puts("失敗")
    puts ex.message
  end

  #検出された顔に対してどんな処理を行なうか
  detector.detect_objects(grayimage_equalize_hist).each do |region|
    begin
      #set_roiは引数に位置を指定しトリミングする
      face = image.set_roi(region)
        face.save "face_#{img_count}.png"
      img_count+=1
    rescue => ex
      puts "#{Time.now} error"
      puts ex.message
    end
  end
  puts "終了"
  Dir.chdir("../img")
end
