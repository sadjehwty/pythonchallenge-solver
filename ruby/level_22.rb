# http://www.pythonchallenge.com/pc/hex/copper.html
require 'rmagick'
include Magick
img=ImageList.new '../resources/white.gif'
point=[]
img.each do |i|
 i.each_pixel do |p,c,r|
  point<< [c-100,r-100] if p.to_hsla[2]>0
 end
end
out=Image.new(200,50)
x,y=2,2
point.each do |dx,dy|
x+=30 if dx==0 and dy==0
x+=dx
y+=dy
out.pixel_color x,y,'black'
end
out.write '22.gif'
puts "Open 22.gif"
