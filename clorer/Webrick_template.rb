# -*- coding: utf-8 -*-

# -*- coding: utf-8 -*-
require 'webrick'

class TestContentServlet <
    WEBrick::HTTPServlet::AbstractServlet #クラスの継承

  def do_GET(req,res)
    res.body = "This is #{req.path}<br>" #ページ内容を代入
    res.content_type = WEBrick::HTTPUtils.mine_type(req.path_info,WEBrick::HTTPUtils::DefaultMimeTypes)
  end
end

srv = WEBrick::HTTPServer.new(:BindAddres => '127.0.0.1',:Port => 7777)
srv.mount('/' ,TestContentServlet)
trap("INT"){srv.shutdown}
srv.start
