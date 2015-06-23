#coding:utf-8

require 'rmagick'
require 'prawn'
include Magick

class Pdf

  def initialize()
    @loadpdf = nil
    @splitimges = Array.new
    @resizeimages = Array.new
  end
  def load(file = "")
    begin
      @loadpdf = Magick::ImageList.new(file)
      print "PDFの読み込みが完了しました\n"
    rescue
      print "指定されたファイルがPDFじゃない可能性がある。あるいは指定されていません\n"
      return 1
    end
  end
  def split
    begin
      @loadpdf.each_with_index do  |img|
        @splitimges.push(img)
      end
      print "分割が完了しました\n"
      images_save
    rescue => ex
      print "エラーが起きました => #{ex}\n"
    end
  end
  def construct(out_fname="hogehoge")
    begin
      File.open(out_fname,"wb"){ |f|
      @splitimges.each do |img|

        end
        }
    rescue => ex
      print "pdfの作成を失敗しました\n"
      print $@
      print ex
    end
  end
  def images_save
    if File::exists?("tmp") == false
      Dir::mkdir("./tmp")
      print "tmpフォルダを作成しました"
    end
    Dir.chdir("./tmp")
    begin
    @splitimges.each_with_index do |img,i|
      img.write"#{i.to_s}.jpg"
      end
    rescue
      print "画像の保存を失敗しました\n"
      print "tmpフォルダを削除します"
      Dir::rmdir("tmp")
    end
  end
end
        
class Kindle < Pdf
  def initialize()
    @Resize_x = 658
    @Resize_y = 905
    super()
  end
  def kindle_img_resize
    begin
      Dir.glob('*,{jpg}',File::FNM_CASEFOLD).each do |file|
        @resizeimages.push(Magick::Image.read(file).resize(@Resie_x,@Resize_y))
      end
    rescue => ex
      print "リサイズ時にエラーが起きました => #{ex}\n"
      return 0
    end
    print "リサイズが完了しました \n"
=begin
    begin
    @splitimges.each do |img|
        img = img.resize(@Resize_x,@Resize_y)
      end
      print "リサイズが完了しました\n"
    rescue => ex
      print "リサイズ時にエラーが起きました => #{ex}\n"
    end
=end
  end
end

out_fname = ARGV[1]
in_pdf = ARGV[0]

pdf = Kindle.new()
pdf.load(in_pdf)
pdf.split
pdf.kindle_img_resize
#pdf.construct(out_fname)
