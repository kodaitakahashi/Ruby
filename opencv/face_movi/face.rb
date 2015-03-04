# -*- coding: utf-8 -*-
require 'opencv'
include OpenCV

i=0
#分類器の指定
detector = CvHaarClassifierCascade::load '/usr/local/Cellar/opencv/2.4.9/share/OpenCV/haarcascades/haarcascade_frontalface_alt.xml'
#カレントディレクトの移動
Dir.chdir('./result')
#カレントディレクトで該当するすべてのファイルを対象にする
Dir.glob('*.{jpg,jpeg,png}',File::FNM_CASEFOLD).each do |filename|
  puts"ファイルあり"
  begin
    image = IplImage.load(filename)
    puts("ファイル読み込み成功")
  rescue
    puts("失敗")
    return 1
  end
  #検出された顔に対してどんな処理を行なうか
  detector.detect_objects(image).each do |region|
    begin
    image.rectangle! region.top_left, region.bottom_right,:color => OpenCV::CvColor::Red
      image.save "#{File::basename(filename)}"
    rescue => ex
      puts "#{Time.now} error"
      puts ex.message
    end
  end
  puts "終了"
end
