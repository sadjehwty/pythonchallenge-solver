# http://www.pythonchallenge.com/pc/return/italy.html
require 'rubygems'
require 'RMagick'
include Magick
def get i
  t=i
  l=100
  x=t
  y=0
  n=0
  ux=0
  sx=0
  loop do
    case n
      when 0
        if t<l
          x,y=sx+t,ux
          break
        else
          t-=l
          l-=1
          ux+=1
          n+=1
          redo
        end
      when 1
        if t<l
          x,y=99-sx,ux+t
          break
        else
          n+=1
          t-=l
          redo
        end
      when 2
        if t<l
          x,y=98-sx-t,100-ux
          break
        else
          n+=1
          t-=l
          l-=1
          redo
        end
      when 3
        if t<l
          x,y=sx,99-ux-t
          break
        else
          sx+=1
          n=0
          t-=l
          redo
        end
    end
  end
  [x,y]
end
im=ImageList.new '../resources/wire.png'
out=Image.new 100,100
10000.times do |i|
  px=get i
  out.pixel_color(px[0],px[1],im.pixel_color(i,1))
end
out.write '14.png'
puts "Open 14.png"
