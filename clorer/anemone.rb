#-*- coding: utf-8 -*-

require 'anemone'

URL = 'http://konbu13.hatenablog.com/'
REGEXP = /category/

Anemone.crawl(URL) do |anemone|
  anemone.focus_crawl do |page| #クロールごとに読み出される

    page.links.keep_if{ |link| #条件に一致するリンクだけ残す
      link.to_s.match(REGEXP) #linksはanemoneが次にクロールする候補リスト
    }

  end

  anemone.on_every_page do |page| #メインの処理
    print page.doc.at('title').inner_html
  end
end
