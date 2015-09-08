# http://www.pythonchallenge.com/pc/def/oxygen.html
require 'rmagick'
include Magick
i=ImageList.new '../resources/oxygen.png'
j=2
t=""
while j<607
  t<< i.pixel_color(j,47).red.modulo(256).chr
  j+=7
end
a=t.scan(/(\d{3})+,?/)
t<< " => "
a.each do |i|
  t<< i[0].to_i.chr
end
puts t
