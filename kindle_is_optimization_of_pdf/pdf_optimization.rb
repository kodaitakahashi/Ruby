#coding:utf-8

require 'rmagick'
include Magick

class Pdf
  attr_reader :loadpdf, :splitimages

  def initialize()
    @loadpdf = nil
    @splitimgs = Array.new
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
      @splitimgs.push(img)
      end
    rescue
      print "分割時に不具合が起きました"
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
  def resize_img
    for img in @splitimgs.length
      img.resize(@Resize_x,@Resize_y)
    end
  end
end

out_fname = ARGV[1]
in_pdf = ARGV[0]

pdf = Kindle.new(in_pdf)
pdf.load(in_pdf)
#pdf.split
#pdf.resize_img
#pdf.construct(out_fname)
