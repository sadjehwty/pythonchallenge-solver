# http://www.pythonchallenge.com/pc/ring/yankeedoodle.html
require 'rubygems'
require 'RMagick'
include Magick
f=File.read "../resources/yankeedoodle.csv"
a=f.split(/\s/)
a.delete ""
n=[]
a.length.times do |i| n<< a[i].to_f end
x=53
root=Math.sqrt(n.length).to_i
while x<=root
  if (n.length%x).zero?
    y=n.length/x
    img=Image.constitute(x,y,"I",n)
    img.rotate!(90).flop!
    img.write "#{x}x#{y}.png"
  end
  x+=1
end
x=""
begin
  (0...a.length).step(3) do |i|
    w=a[i].to_s[5].chr
    w<< a[i+1].to_s[5].chr
    w<< a[i+2].to_s[6].chr
    x<< w.to_i.chr
  end
rescue
end
x=~ /at (\w+)\",/
puts $1