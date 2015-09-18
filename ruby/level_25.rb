# http://www.pythonchallenge.com/pc/hex/lake.html
require 'net/http'
require 'ruby-audio'
require 'tempfile'
require 'rmagick'
include Magick
list=ImageList.new
head="BMf*\x00\x00\x00\x00\x00\x006\x00\x00\x00(\x00\x00\x00<\x00\x00\x00<\x00\x00\x00\x01\x00\x18\x00\x00\x00\x00\x000*\x00\x00\x13\v\x00\x00\x13\v\x00\x00\x00\x00\x00\x00\x00\x00\x00\x00".force_encoding Encoding::ASCII_8BIT
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
  Tempfile.open("temp", encoding: 'ascii-8bit') do |t|
    t.write ret
    t.flush
    RubyAudio::Sound.open(t.path) do |a|
      buf=a.read(:short, t.size)
      buf=buf.to_a.map do |v|
        v /= 256
	v += 128
	v.chr
      end
      i=Image.from_blob head+buf.join
      i[0].flip!
      i[0].page=Rectangle.new 300, 300, (n-1).modulo(5)*60, 60*((n-1)/5)
      list<< i[0]
    end
  end
end
list.mosaic.write "25.bmp"
puts "Open 25.bmp"
