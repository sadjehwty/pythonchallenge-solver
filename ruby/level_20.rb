# http://www.pythonchallenge.com/pc/hex/idiot2.html
require 'rubygems'
require 'zipruby'
require 'net/http'
require 'tempfile'
def get http,req,i
  req.range = i..i+1
  http.start{|h| h.request req}.body
end
req= Net::HTTP::Get.new '/pc/hex/unreal.jpg'
req.basic_auth 'butter','fly'
http=Net::HTTP.new "www.pythonchallenge.com",80
nck=get(http,req,30295).strip
tf=Tempfile.open("20.zip")
tf.write get(http,req,$1.to_i) if get(http,req,2123456712) =~ / (\d+)./
tf.flush
ret='package.pack'
Zip::Archive.open(tf.path) do |ar|
  ar.decrypt(nck[0..6].reverse)
  ar.each do |zf|
    File.open(zf.name,"wb"){|f| f.write zf.read} if zf.name == ret
  end
end
tf.close
puts "Next level is #{ret}"