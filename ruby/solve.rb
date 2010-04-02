=begin
bz2
libxml-xmlrpc
rmagick
zipruby
ruby-audiofile
gecoder
=end

def l25 # http://www.pythonchallenge.com/pc/hex/lake.html
require 'net/http'
require 'audiofile'
require 'tempfile'
require 'RMagick'
include Magick
list=ImageList.new
head="BMf*\000\000\000\000\000\0006\000\000\000(\000\000\000<\000\000\000<\000\000\000\001\000\030\000\000\000\000\0000*\000\000\023\v\000\000\023\v\000\000\000\000\000\000\000\000\000\000"
http=Net::HTTP.new "www.pythonchallenge.com",80
(1..25).each do |n|
 req= Net::HTTP::Get.new "/pc/hex/lake#{n}.wav"
 req.basic_auth 'butter','fly'
 ret=""
 begin
  ret=http.start{|h| h.request req}.body
 rescue
  redo
 end
  name="lake#{n}.png"
  Tempfile.open("temp"){|t| 
   t.write ret
   t.flush
   AudioFile.open(t.path,"r"){ |a|
     i=Image.from_blob head+a.read
     i[0].flip!
     i[0].page=Rectangle.new 300, 300, (n-1).modulo(5)*60, 60*((n-1)/5)
     list<< i[0]
   }
  }
end
list.mosaic.write "25.bmp"
"Guarda 25.bmp"
end

def l26 # http://www.pythonchallenge.com/pc/hex/decent.html
require 'digest/md5'
s=File.read '../resources/mybroken.zip'
b=false
f="mybroken.gif"
s.length.times do |i|
 256.times do |j|
  r=s[0,i] + j.chr + s[i+1,s.length]
  if Digest::MD5.hexdigest(r) == 'bbb8b499a0eef99b52c7f13f4e78c24b'
    require 'tempfile'
    require 'zipruby'
    Tempfile.open('zip') do |t|
      t.write r
      t.flush
      Zip::Archive.open(t.path) do |z|
	File.open(f,"wb"){|ex| ex.write z.fopen(z.locate_name(f)).read}
      end
    end
    b=true
    break
  end
  break if b
 end
end
"Guarda #{f} + \"boat\""
end

def l27 # http://www.pythonchallenge.com/pc/hex/speedboat.html
  require 'RMagick'
  include Magick
  img=Image.read('../resources/zigzag.gif').first
  a=img.get_pixels 0,0,320,270
  atad=""
  q=QuantumRange+1
  q/=256
  a.each do |p| atad<< (p.red/q) end
  f=File.read('../resources/zigzag.gif')[13...13+256*3]
  palette=""
  (0...f.length).step(3) do |c| palette<< f[c] end
  ettelap=[]
  palette.length.times do |i| ettelap[palette[i]]=i end
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
  require 'bz2'
  f=BZ2::bunzip2 f
  a=f.split(/\s/).uniq
  ret=nil
  require 'net/http'
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
  ret
end

def l28 # http://www.pythonchallenge.com/pc/ring/bell.html
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
  "Guido van Rossum".split[0]
end

def l29 # http://www.pythonchallenge.com/pc/ring/guido.html
  s=File.read '../resources/silence.txt'
  n=""
  s.each do |l| n<< (l.length-2).chr end
  require 'bz2'
  BZ2::bunzip2(n) =~ /I am (.+)!/
  $1
end

def l30 # http://www.pythonchallenge.com/pc/ring/yankeedoodle.html
  f=File.read "../resources/yankeedoodle.csv"
  a=f.split(/\s/)
  a.delete ""
  n=[]
  a.length.times do |i| n<< a[i].to_f end
  require 'RMagick'
  include Magick
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
  $1
end

def l31 # http://www.pythonchallenge.com/pc/ring/grandpa.html
  require 'RMagick'
  require 'tempfile'
  require 'complex'
  include Magick
  f=File.read('../resources/mandelbrot.gif')
  f[13+124*3]="\374\000\000\375\000\000\376\000\000\377\000\000"
  img=Tempfile.open("my.gif")
  img.write f
  img.flush
  q=QuantumRange/255
  palette=[]
  f=f[13...13+128*3]
  (0...f.length).step(3) do |c| palette<< Pixel.new(q*f[c],q*f[c+1],q*f[c+2],0) end
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
  "grandpa rock?\tUFO #{diffs}?"
end

class Nonogram 
 require 'gecoder' 
 include Gecode::Mixin
 def initialize(row_rules, col_rules)
  filled_is_an bool_var_matrix(row_rules.size, col_rules.size)
  row_rules.each_with_index do |row_rule, i| 
   filled.row(i).must.match parse_regex(row_rule)
  end
  col_rules.each_with_index do |col_rule, i|
   filled.column(i).must.match parse_regex(col_rule)
  end
  branch_on filled, :variable => :none, :value => :max
 end
 def parse_regex(a)
  r = [repeat(false)]
  a.each_with_index do |e,i| 
   r << repeat(true,e,e)
   r << at_least_once(false)  if i < a.length-1
  end
  r << repeat(false)
  r
 end
end

def l32 # http://www.pythonchallenge.com/pc/rock/arecibo.html
 def solve s
  a=File.read(s).to_a[4..-1]
  enne=[[],[]]
  i=0
  a.each do |line|
   line.chomp!
   if line=~/#/
    i+=1
    next
   end
   next if line.length<1
   line=line.split(/\s/)
   temp=[]
   line.each do |n| temp<< n.to_i end
   enne[i]<< temp
  end
  row_rules = enne[0]
  col_rules = enne[1]
  nonogram = Nonogram.new(row_rules, col_rules)
  num_solutions = 0
  ret=""
  nonogram.each_solution do |s| 
   num_solutions += 1
   s.filled.values.enum_slice(s.filled.column_size).each do |row|
    ret<< row.map{ |filled| filled ? "#" : " " }.join + "\n"
   end
  end
  ret
 end
 s=solve("../resources/warmup.txt")
 s=solve("../resources/up.txt")
 "free speech, not free beer"=~/free speech, not free (.+)/
 $1
end

def l33 # http://www.pythonchallenge.com/pc/rock/beer.html
 require 'rubygems'
 require 'RMagick'
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
 "Leggi 33_X.png"
end

def print s
  puts "#{s}:"
  puts "\t #{eval("l#{s}")}"
end

def print1 s
  puts "#{s}:"
  puts eval("l#{s}")
end

def print2 s
 puts "#{s}:"
 p eval("l#{s}")
end

def lall
 (0..4).each do |f| print f end
 (5..6).each do |f| print1 f end
 print 7
 print2 8
 (9..17).each do |f| print f end
 print1 18
 (19..20).each do |f| print f end
 print1 21
 (22..26).each do |f| print f end
 print2 27
 (28..33).each do |f| print f end
 ""
end

puts "Quesito n.: "  
STDOUT.flush  
puts eval "l#{gets.chomp}"
