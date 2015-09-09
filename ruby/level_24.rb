# http://www.pythonchallenge.com/pc/hex/ambiguity.html
require 'zipruby'
require 'rmagick'
require 'tempfile'
include Magick
from,to=639, 410241
img = Image.read('../resources/maze.png').first
delta=img.columns
maxY=img.rows
img=img.get_pixels(0, 0,delta, maxY)
max=img.length
point=[from]
visit=[]
visit[from]=true
w=Pixel.from_color 'white'
pos=from
count=0
while pos!=to && count < 1000000
  count+=1
  b=false
  [pos-delta,pos+delta,pos+1,pos-1].each do |dir|
    if dir>=0 && img[dir] != w && !visit[dir]
      pos=dir
      visit[pos] = true
      point << pos
      b=true
      break
    end
    break if b
  end
  unless b
    point.pop
    pos=point.last
    count-=1
  end
end
q=QuantumRange+1
q/=256 
f=Tempfile.open("24.zip")
point.length.times do |i|
  f.write( (img[point[i]].red/q).chr) if i.odd?
end
f.flush
Zip::Archive.open(f.path){|z|
  File.open("maze.jpg","wb"){|ex| ex.write z.fopen(z.locate_name("maze.jpg")).read}
}
f.close
puts "Open maze.jpg"
