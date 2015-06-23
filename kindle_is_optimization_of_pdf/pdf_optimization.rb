#coding:utf-8

require 'rmagick'
include Magick

class Pdf
  attr_reader :loadpdf, :splitimages

  def initialize()
    @loadpdf = nil
    @splitimges = Array.new
  end
  def load(file = "")
    begin
      @loadpdf = Magick::ImageList.new(file)
      print("PDFの読み込みが完了しました")
    rescue
      print "指定されたファイルがPDFじゃない可能性がある。あるいは指定されていません"
      return 1
    end
  end
  def split
    begin
    @loadpdf.each do  |img|
        @splitimges.push(img)
      end
      print "分割が完了しました"
    rescue => ex
      print "エラーが起きました => #{ex}"
    end
  end
  def construct(out_fname="hogehoge")
    begin
    Prawn::Document.generate(out_fname) do
      @splitimgs.each do |img|
        image img, :at => [-1*bounds.absolute_left,bounds.absolute_top],
        :fit => [bounds.absolute_right+bounds.absolute_leftmbounds.absolute_top+bounds.absolute_bottom]
        start_new_page
      end
      end
    rescue
      print "pdfの作成を失敗しました"
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
    @splitimges.each do |img|
      img.resize(@Resize_x,@Resize_y)
      end
      print "リサイズが完了しました"
    rescue => ex
      print "リサイズ時にエラーが起きました => #{ex}"
    end
  end
end

out_fname = ARGV[1]
in_pdf = ARGV[0]

pdf = Kindle.new()
pdf.load(in_pdf)
pdf.split
pdf.kindle_img_resize
#pdf.construct(out_fname)
