# http://www.pythonchallenge.com/pc/ring/bell.html
require 'rubygems'
require 'RMagick'
include Magick
img=Image.read('../resources/bell.png').first
green=""
q=(QuantumRange+1)/256
img=img.get_pixels 0,0,img.columns,img.rows
img.each do |p|
  green<< (p.green/q).chr
end
i=0
valu=""
while i<green.length
  v=(green[i]-green[i+1]).abs
  valu<< v.chr if v!=42
  i+=2
end
#puts valu
puts "Guido van Rossum".split[0]