# http://www.pythonchallenge.com/pc/rock/beer.html
require 'rmagick'
include Magick

def histo img
  a=[]
  q=QuantumRange/255
  img.each_pixel do |p,x,y|
    a[p.red/q]=0 if a[p.red/q].nil?
    a[p.red/q]+=1
  end
  a
end

def equ a,h
  q=QuantumRange/255
  w=Pixel.from_color 'white'
  b=Pixel.from_color 'black'
  a.each_with_index do |v,i|
    a[i]=(h.index(v).nil?)?b:w
  end
  a
end

def max img
  max1=max=Pixel.from_color('black')
  img.each_pixel do |p,x,y|
    max=p if p.red>max.red
    max1=p if p.red>max1.red && max.red != p.red
  end
  [max,max1]
end

img=Image.read("../resources/beer2.png").first
g=[15,17,21,22,24,26,27,29]
i=0
m=max img
begin
  a=img.get_pixels 0,0,img.columns,img.rows
  a.delete m[0]
  a.delete m[1]
  l=Math.sqrt a.length
  img=Image.new l,l
  img.store_pixels 0,0,img.columns,img.rows,a
  m=max img
  unless g.index(i).nil?
    loc=Image.new l,l
    loc.store_pixels 0,0,img.columns,img.rows,equ(a,m)
    loc.write "33_#{i}.png"
  end
  h= histo img
  i+=1
end while h.length > 3
puts "Open 33_*.png"