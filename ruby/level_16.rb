# http://www.pythonchallenge.com/pc/return/mozart.html
require 'rmagick'
include Magick

def get img
px=Pixel.new 65535,0,65535,0
img.columns.times do |i|
return i-1 if (img.pixel_color(i,0)<=> px).zero?
end
end

img = ImageList.new "../resources/mozart.gif"
img.rows.times do |y|
  row=img.crop(0,y,img.columns,1)
  i = get row
  row=row.roll(-i,0)
  pix=row.get_pixels(0,0,640,1)
  img.store_pixels(0,y,img.columns,1,pix)
end
img.write '16.gif'
puts "Open 16.gif"
