# http://www.pythonchallenge.com/pc/hex/lake.html
require 'rubygems'
require 'net/http'
require 'audiofile'
require 'tempfile'
require 'RMagick'
include Magick
list=ImageList.new
head="BMf*\000\000\000\000\000\0006\000\000\000(\000\000\000<\000\000\000<\000\000\000\001\000\030\000\000\000\000\0000*\000\000\023\v\000\000\023\v\000\000\000\000\000\000\000\000\000\000"
http=Net::HTTP.new "www.pythonchallenge.com",80
(1..25).each do |n|
 req= Net::HTTP::Get.new "/pc/hex/lake#{n}.wav"
 req.basic_auth 'butter','fly'
 ret=""
 begin
  ret=http.start{|h| h.request req}.body
 rescue
  redo
 end
  name="lake#{n}.png"
  Tempfile.open("temp"){|t| 
   t.write ret
   t.flush
   AudioFile.open(t.path,"r"){ |a|
     i=Image.from_blob head+a.read
     i[0].flip!
     i[0].page=Rectangle.new 300, 300, (n-1).modulo(5)*60, 60*((n-1)/5)
     list<< i[0]
   }
  }
end
list.mosaic.write "25.bmp"
puts "Open 25.bmp"