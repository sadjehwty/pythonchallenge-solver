# http://www.pythonchallenge.com/pc/return/5808.html
require 'rubygems'
require 'RMagick'
include Magick
ini=ImageList.new '../resources/cave.jpg'
out=Image.new ini.columns,ini.rows/2
x=0
while x<ini.columns
  y=x%2
  k=0
  while y<ini.rows
    out.pixel_color(x,k,ini.pixel_color(x,y))
    y+=2
    k+=1
  end
  x+=1
end
out.write '11.jpg'
puts "Open 11.jpg"