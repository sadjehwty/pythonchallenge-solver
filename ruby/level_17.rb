# http://www.pythonchallenge.com/pc/return/romance.html
require 'tempfile'
require 'net/http'
require 'rbzip2'
def cicle i
 ret=""
 begin
  res=nil
  begin
    res=Net::HTTP.start("www.pythonchallenge.com",80).get("/pc/def/linkedlist.php?busynothing="+i)
  rescue
    redo
  end
  s=res.response['set-cookie']
  s=(s=~/info=(.+?);/)?$1:nil
  if s.length == 1
   ret+=s=="+"?" ":s
  else
   ret+=s[1..3].to_i(16).chr
  end
  i= (res.body=~/and the next busynothing is (\d+)/)?$1:nil
 end while i
 ret
end
t=Tempfile.new 'tmp'
t.write cicle("12345")
t.rewind
ret=RBzip2::Decompressor.new t
ret=ret.read
require 'xmlrpc/client'
server = XMLRPC::Client.new2('http://www.pythonchallenge.com/pc/phonebook.php')
url="/pc/stuff/"+(server.call("phone","Leopold")=~/-(.+)/?$1.downcase():"")+".php"
msg=ret=~/"(.+)"/?$1:nil
msg=Net::HTTP.start("www.pythonchallenge.com",80).get url,{'Cookie'=> 'info='+msg}
puts msg.body=~/the (.+).<\/font>/?$1:nil
