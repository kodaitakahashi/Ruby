# -*- coding: utf-8 -*-

def ffmpeg(mp4file)
  makedir
  Dir.chdir("./result")
  system ("ffmpeg -i #{mp4file} -r 5 test-%04d.png")
end

def makedir()
    puts " カレントディレクトリにresultフォルダがあるか調べています…"
  if File::exists?("result") == false 
    Dir::mkdir("./result")
    puts "カレントディレクトリresultディレクトリを作りました"
  else
    puts "確認完了"
  end
end

if ARGV[0] == nil
  puts "引数ナシ"
else
  ffmpeg(ARGV[0])
end
