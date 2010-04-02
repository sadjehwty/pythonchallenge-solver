# http://www.pythonchallenge.com/pc/return/romance.html
require 'rubygems'
require 'net/http'
require 'bz2'
def cicle i
 ret=""
 begin
  res=Net::HTTP.start("www.pythonchallenge.com",80).get("/pc/def/linkedlist.php?busynothing="+i)
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
bz2=cicle("12345")
ret=BZ2::bunzip2 bz2
require 'xmlrpc/client'
server = XMLRPC::Client.new2('http://www.pythonchallenge.com/pc/phonebook.php')
url="/pc/stuff/"+(server.call("phone","Leopold")=~/-(.+)/?$1.downcase():"")+".php"
msg=ret=~/"(.+)"/?$1:nil
msg=Net::HTTP.start("www.pythonchallenge.com",80).get url,{'Cookie'=> 'info='+msg}
puts msg.body=~/the (.+).<\/font>/?$1:nil