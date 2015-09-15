# http://www.pythonchallenge.com/pc/ring/grandpa.html
require 'rmagick'
require 'tempfile'
require 'complex'
include Magick
f=File.open('../resources/mandelbrot.gif', encoding: 'ascii-8bit').read
f[13+124*3]="\374\000\000\375\000\000\376\000\000\377\000\000".force_encoding Encoding::ASCII_8BIT
img=Tempfile.open("my.gif")
img.write f
img.flush
q=QuantumRange/255
palette=[]
f=f[13...13+128*3]
(0...f.length).step(3) do |c| palette<< Pixel.new(q*f[c].ord,q*f[c+1].ord,q*f[c+2].ord,0) end
img=Image.read(img.path).first
img.flip!
x=img.columns
y=img.rows
img=img.get_pixels 0,0,x,y
img.length.times do |i| img[i]=palette.index(img[i]) end
diffs=0
cx,cy,dcx,dcy=0.34,0.57,0.036/x,0.027/y
y.times do |j|
  b=cy+j*dcy
  x.times do |i|
    a=cx+i*dcx
    iter,c,pix=-1,0,img[i+j*x]
    while iter<128 && c.abs<2
      iter+=1
      c=c**2 + Complex(a,b)
    end 
    diffs+=1 if pix != iter && pix<127
  end
end
puts "grandpa rock?\tUFO #{diffs}?"