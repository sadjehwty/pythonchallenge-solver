# http://www.pythonchallenge.com/pc/hex/speedboat.html
require 'rmagick'
include Magick
require 'rbzip2'
require 'tempfile'
require 'net/http'
img=Image.read('../resources/zigzag.gif').first
a=img.get_pixels 0,0,320,270
atad=""
q=QuantumRange+1
q/=256
a.each do |p| atad<< (p.red/q) end
f=File.open('../resources/zigzag.gif',{encoding: 'ascii-8bit'}).read()[13...13+256*3]
palette=""
(0...f.length).step(3) do |c| palette<< f[c] end
ettelap=[]
palette.length.times do |i| ettelap[palette[i].ord]=i end
data=""
atad.each_byte do |b| data<< ettelap[b] end
f=""
p1,p2=data[1...data.length],atad[0...data.length-1]
black=Pixel.from_color 'black'
white=Pixel.from_color 'white'
px=[]
p1.length.times do |i|
  unless(p1[i]<=>p2[i]).zero?
    f<< p1[i]
    px<< black
  else
    px<< white
  end
end
key=Image.new(320,270)
key.store_pixels 0,0,320,270,px<< white
key.write '27.gif'
t=Tempfile.new 'tmp'
t.write f
t.rewind
bz2  = RBzip2::Decompressor.new t
f=bz2.read
t.close
a=f.split(/\s/).uniq
ret=nil
http=Net::HTTP.new "www.pythonchallenge.com",80
req= Net::HTTP::Get.new "/pc/ring/bell.html"
b=false
a.each do |u|
  a.each do |p|
    req.basic_auth u,p
    begin
      next if http.start{|h| h.request req}.code!="200"
      ret={"user"=>u,"pwd"=>p}
      b=true
      break
    rescue
      next
    end
  end
  break if b
end
p ret
