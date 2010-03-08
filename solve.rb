=begin
bz2
libxml-xmlrpc
rmagick
zipruby
ruby-audiofile
gecoder
=end

require 'rubygems'

def l0  # http://www.pythonchallenge.com/pc/def/0.html
  2**38
end

def l1  # http://www.pythonchallenge.com/pc/def/274877906944.html
  def f s
    t=""
    s.size.times do |i|
      c=s[i].chr
      if c=~/\w/
        t<< c.next.next
      else
        t<< c
      end
    end
    t.gsub("aa","a").gsub("ab","b")
  end
  s="g fmnc wms bgblr rpylqjyrc gr zw fylb. rfyrq ufyr amknsrcpq ypc dmp. bmgle gr gl zw fylb gq glcddgagclr ylb rfyr'q ufw rfgq rcvr gq qm jmle. sqgle qrpgle.kyicrpylq() gq pcamkkclbcb. lmu ynnjw ml rfc spj."
  f(s) + " => " + f("map")
end

def l2  # http://www.pythonchallenge.com/pc/def/ocr.html
  s=File.read 'rc/2.txt'
  temp=""
  s.size.times do |i|
    temp<< s[i,1] if s.count(s[i,1])<20
  end
  temp
end

def l3  # http://www.pythonchallenge.com/pc/def/equality.html
  s=File.read 'rc/3.txt'
  temp=""
  s.scan(/[a-z][A-Z]{3}([a-z])[A-Z]{3}[a-z]/).each do |l|
    temp<< l[0]
  end
  temp
end

def l4  # http://www.pythonchallenge.com/pc/def/linkedlist.php
  require 'net/http'
  i="12345"
  begin
    res=Net::HTTP.start("www.pythonchallenge.com",80) { |http|
      http.get("/pc/def/linkedlist.php?nothing="+i)}
    j=i
    i= (res.body=~/and the next nothing is (\d+)/)?$1:nil
  end while i
  i=(j.to_i/2).to_s
  begin
    res=Net::HTTP.start("www.pythonchallenge.com",80) { |http|
      http.get("/pc/def/linkedlist.php?nothing="+i)}
    i= (res.body=~/and the next nothing is (\d+)/)?$1:nil
  end while i
  res.body
end

def l5  # http://www.pythonchallenge.com/pc/def/peak.html
  @mark=Object.new
  def marker stack
    stack.rindex @mark
  end

  def load(stream)
    memo, stack = {}, []
    loop do
      case stream.getc.chr
      when "I"
        stack << stream.readline.chomp.to_i
      when "S"
        stack << eval(stream.readline.chomp)
      when "t", "l" # e.g) ... [ 1,2,MARKER,3,4 ] => [ 1,2,[3,4] ]
        stack[marker(stack)..-1] = [ stack[marker(stack)+1..-1] ]
      when "("
        stack << @mark
      when "a" # e.g) ... [ [ ],1,2 ] => [ [ 1, 2] ]
        v = stack.pop; stack.last << v
      when "p"
        memo[stream.readline.chomp] = stack.last
      when "g"
        stack << memo[stream.readline.chomp]
      when "."
        return stack.pop
      end
    end
  end
  load(open("rc/banner.p")).map{|row|row.inject(""){|r,(k,v)|r+=k*v}}
end

def l6  # http://www.pythonchallenge.com/pc/def/channel.html
  require 'zipruby'
  i="90052"
  f=""
  Zip::Archive.open("rc/channel.zip"){ |file|
    begin
      l=file.locate_name "#{i}.txt"
      f<< file.get_fcomment(l)
      s=file.fopen(l).read
      i= s=~ /Next nothing is (\d+)/ ? $1:nil
    end until i.nil?
  }
  f
end

def l7  # http://www.pythonchallenge.com/pc/def/oxygen.html
  require 'RMagick'
  include Magick
  i=ImageList.new 'rc/oxygen.png'
  j=2
  t=""
  while j<607
    t<< i.pixel_color(j,47).red.modulo(256).chr
    j+=7
  end
  a=t.scan(/(\d{3})+,?/)
  t<< " => "
  a.each do |i|
    t<< i[0].to_i.chr
  end
  t
end

def l8  # http://www.pythonchallenge.com/pc/def/integrity.html
  require 'bz2'
  a={'user'=>"BZh91AY&SYA\xaf\x82\r\x00\x00\x01\x01\x80\x02\xc0\x02\x00 \x00!\x9ah3M\x07<]\xc9\x14\xe1BA\x06\xbe\x084",
    'pwd'=>"BZh91AY&SY\x94$|\x0e\x00\x00\x00\x81\x00\x03$ \x00!\x9ah3M\x13<]\xc9\x14\xe1BBP\x91\xf08"}
  a.each_key do |k|
    a[k]=BZ2::bunzip2 a[k]
  end
  a
end

def l9  # http://www.pythonchallenge.com/pc/return/good.html
  require 'RMagick'
  include Magick
  first=[146,399,163,403,170,393,169,391,166,386,170,381,170,371,170,355,169,346,167,335,170,329,170,320,170,
    310,171,301,173,290,178,289,182,287,188,286,190,286,192,291,194,296,195,305,194,307,191,312,190,316,
    190,321,192,331,193,338,196,341,197,346,199,352,198,360,197,366,197,373,196,380,197,383,196,387,192,
    389,191,392,190,396,189,400,194,401,201,402,208,403,213,402,216,401,219,397,219,393,216,390,215,385,
    215,379,213,373,213,365,212,360,210,353,210,347,212,338,213,329,214,319,215,311,215,306,216,296,218,
    290,221,283,225,282,233,284,238,287,243,290,250,291,255,294,261,293,265,291,271,291,273,289,278,287,
    279,285,281,280,284,278,284,276,287,277,289,283,291,286,294,291,296,295,299,300,301,304,304,320,305,
    327,306,332,307,341,306,349,303,354,301,364,301,371,297,375,292,384,291,386,302,393,324,391,333,387,
    328,375,329,367,329,353,330,341,331,328,336,319,338,310,341,304,341,285,341,278,343,269,344,262,346,
    259,346,251,349,259,349,264,349,273,349,280,349,288,349,295,349,298,354,293,356,286,354,279,352,268,
    352,257,351,249,350,234,351,211,352,197,354,185,353,171,351,154,348,147,342,137,339,132,330,122,327,
    120,314,116,304,117,293,118,284,118,281,122,275,128,265,129,257,131,244,133,239,134,228,136,221,137,
    214,138,209,135,201,132,192,130,184,131,175,129,170,131,159,134,157,134,160,130,170,125,176,114,176,
    102,173,103,172,108,171,111,163,115,156,116,149,117,142,116,136,115,129,115,124,115,120,115,115,117,
    113,120,109,122,102,122,100,121,95,121,89,115,87,110,82,109,84,118,89,123,93,129,100,130,108,132,110,
    133,110,136,107,138,105,140,95,138,86,141,79,149,77,155,81,162,90,165,97,167,99,171,109,171,107,161,
    111,156,113,170,115,185,118,208,117,223,121,239,128,251,133,259,136,266,139,276,143,290,148,310,151,
    332,155,348,156,353,153,366,149,379,147,394,146,399]
  second=[156,141,165,135,169,131,176,130,187,134,191,140,191,146,186,150,179,155,175,157,168,157,163,157,159,
    157,158,164,159,175,159,181,157,191,154,197,153,205,153,210,152,212,147,215,146,218,143,220,132,220,
    125,217,119,209,116,196,115,185,114,172,114,167,112,161,109,165,107,170,99,171,97,167,89,164,81,162,
    77,155,81,148,87,140,96,138,105,141,110,136,111,126,113,129,118,117,128,114,137,115,146,114,155,115,
    158,121,157,128,156,134,157,136,156,136]
  d=Draw.new
  d.stroke 'red'
  im=ImageList.new 'rc/good.jpg'
  a=first+second
  l=a.length/4
  l.times do |i|
    d.line a[i*4],a[i*4+1],a[i*4+2],a[i*4+3]
  end
  d.draw(im)
  im.write('9.jpg')
  'Apri 9.jpg'
end

def l10 # http://www.pythonchallenge.com/pc/return/bull.html
  @rin=[/^333/,/^222/,/^111/,/^33/,/^22/,/^11/,/^3/,/^2/,/^1/]
  @rout=["33","32","31","23","22","21","13","12","11"]
  def rn n
    3-n/3
  end
  def reg s
    return s if s==""
    ret=""
    str=s
    while str.length>0
      @rin.length.times do |i|
        if str=~@rin[i]
          ret<< @rout[i]
          str=str[rn(i)..str.length]
          break
        end
      end
    end
    ret
  end
  def f(n,s)
    k=s
    n.times do
      k=reg(k)
    end
    k
  end
  f(30,"1").length
end

def l11 # http://www.pythonchallenge.com/pc/return/5808.html
  require 'RMagick'
  include Magick
  ini=ImageList.new 'rc/cave.jpg'
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
  "Apri 11.jpg"
end

def l12 # http://www.pythonchallenge.com/pc/return/evil.html
  s=File.read 'rc/evil2.gfx'
  out=[]
  5.times do |i|
    out[i]=[]
  end
  s.length.times do |i|
    out[i.modulo(5)]<< s[i]
  end
  5.times do |i|
    File.open("12_#{i}.png","w+") do |f|
      out[i].each do |c|
        f.write(c.chr)
      end
    end
  end
  "Guarda 12_X.png"
end

def l13 # http://www.pythonchallenge.com/pc/return/disproportional.html
  require 'xmlrpc/client'
  server = XMLRPC::Client.new2('http://www.pythonchallenge.com/pc/phonebook.php')
  server.call("phone","Bert")=~/-(.+)/?$1.downcase():""
end

def l14 # http://www.pythonchallenge.com/pc/return/italy.html
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
  im=ImageList.new 'rc/wire.png'
  out=Image.new 100,100
  10000.times do |i|
    px=get i
    out.pixel_color(px[0],px[1],im.pixel_color(i,1))
  end
  out.write '14.png'
  "Apri 14.png"
end

def l15 # http://www.pythonchallenge.com/pc/return/uzi.html
  require 'date'
  i=2006
  n=0
  out=0
  while n<3
    if Date.civil(i,1,26).wday==1
      n+=1
      out=i
    end
    i-=10
  end
  "Google: 27/1/#{out}?"
end

def l16 # http://www.pythonchallenge.com/pc/return/mozart.html
require 'RMagick'
include Magick

def get img
px=Pixel.new 65535,0,65535,0
img.columns.times do |i|
return i-1 if (img.pixel_color(i,0)<=> px).zero?
end
end

img = ImageList.new "rc/mozart.gif"
img.rows.times do |y|
  row=img.crop(0,y,img.columns,1)
  i = get row
  row=row.roll(-i,0)
  pix=row.get_pixels(0,0,640,1)
  img.store_pixels(0,y,img.columns,1,pix)
end
img.write '16.gif'
"Guarda 16.gif"
end

def l17 # http://www.pythonchallenge.com/pc/return/romance.html
def cicle i
 ret=""
 begin
  res=Net::HTTP.start("www.pythonchallenge.com",80).get("/pc/def/linkedlist.php?busynothing="+i)
  s=res.response['set-cookie']
  s=(s=~/info=(.+?);/)?$1:nil
  if s.length == 1
   ret+=s=="+"?" ":s
  else
   ret+=s[1..3].to_i(16).chr
  end
  i= (res.body=~/and the next busynothing is (\d+)/)?$1:nil
 end while i
 ret
end
require 'net/http'
bz2=cicle("12345")
require 'bz2'
ret=BZ2::bunzip2 bz2
require 'xmlrpc/client'
server = XMLRPC::Client.new2('http://www.pythonchallenge.com/pc/phonebook.php')
url="/pc/stuff/"+(server.call("phone","Leopold")=~/-(.+)/?$1.downcase():"")+".php"
msg=ret=~/"(.+)"/?$1:nil
msg=Net::HTTP.start("www.pythonchallenge.com",80).get url,{'Cookie'=> 'info='+msg}
msg.body=~/the (.+).<\/font>/?$1:nil
end

def l18 # http://www.pythonchallenge.com/pc/return/balloons.html
require 'zlib'
a=""
Zlib::GzipReader.open 'rc/deltas.gz' do |g| a=g.read end
def str s
  return "" if s.nil? or s.length<1
  ret=""
  a=(s+" ").scan(/.../)
  a.each do |c|
    ret<< c.strip.hex.chr
  end
  ret
end
b=a.split(/\n/)
p1,p2=[],[]
b.each do |l|
  if l=~/(.+)   (.+)/
    p1<< $1.strip
    p2<< $2.strip
  end
end
f=[File.open("18_url.png","wb"),File.open("18_pwd.png","wb"),File.open("18_usr.png","wb")]
i,j=0,0
while j<p2.length
  if (p1[i]<=>p2[j]).zero?
    f[0].write str(p1[i])
    i+=1
    j+=1
  else
    b=true
    unless j+1<p2.length and (p1[i]<=>p2[j+1]).zero?
      f[1].write str(p1[i])
      i+=1
      b=false
    end
    unless (not b and i<p1.length and (p1[i]<=>p2[j]).zero?) or (b and i+1<p1.length and (p1[i+1]<=>p2[j]).zero?)
      f[2].write str(p2[j])
      j+=1
    end
  end
end
ret=""
f.each do |j|
 ret<< "\tGuarda #{j.path}\n"
 j.close
end
ret
end

def l19 # http://www.pythonchallenge.com/pc/hex/bin.html
 require 'base64'
 f=Base64.decode64 File.read('rc/19.eml')
 require 'audiofile'
 a=AudioFile.new( "19.wav", "w" )
 a.rate=22050
 a.channels=1
 a.sample_format=AudioFile::UNSIGNED
 a.bits=8
 a.write f
 a.flush
 a.close
 "Ascolta 19.wav"
end

def l20 # http://www.pythonchallenge.com/pc/hex/idiot2.html
 require 'rubygems'
require 'zipruby'
require 'net/http'
require 'tempfile'
 def get http,req,i
   req.range = i..i+1
   http.start{|h| h.request req}.body
 end
 req= Net::HTTP::Get.new '/pc/hex/unreal.jpg'
 req.basic_auth 'butter','fly'
 http=Net::HTTP.new "www.pythonchallenge.com",80
 nck=get(http,req,30295).strip
 tf=Tempfile.open("20.zip")
 tf.write get(http,req,$1.to_i) if get(http,req,2123456712) =~ / (\d+)./
 tf.flush
ret='package.pack'
Zip::Archive.open(tf.path) do |ar|
  ar.decrypt(nck[0..6].reverse)
  ar.each do |zf|
    File.open(zf.name,"wb"){|f| f.write zf.read} if zf.name == ret
  end
end
tf.close
"Lavora su #{ret}"
end

def l21
require 'zlib'
require 'bz2'
out=File.open('rc/package.pack').read
ret=""
loop do
 case out[0..1]
  when "x\234"
   out=Zlib::Inflate.inflate out
   ret<< " "
  when "BZ"
   out=BZ2.uncompress out
   ret<< "#"
  else
   t=out[-2..-1].reverse
   if t=="BZ" or t=="x\234"
    out.reverse!
    ret<< "\n"
   else break end
 end
end
ret
end

def l22 # http://www.pythonchallenge.com/pc/hex/copper.html
require 'RMagick'
include Magick
img=ImageList.new 'rc/white.gif'
point=[]
img.each do |i|
 i.each_pixel do |p,c,r|
  point<< [c-100,r-100] if p.to_hsla[2]>0
 end
end
out=Image.new(200,50)
x,y=2,2
point.each do |dx,dy|
x+=30 if dx==0 and dy==0
x+=dx
y+=dy
out.pixel_color x,y,'black'
end
out.write '22.gif'
"Guarda 22.gif"
end

def l23 # http://www.pythonchallenge.com/pc/hex/bonus.html
 s=File.read 'rc/23.txt'
 $1 if s=~ /In the face of (\w+)/
end

def l24 # http://www.pythonchallenge.com/pc/hex/ambiguity.html
from,to=639, 410241
require 'RMagick'
include Magick
img = Image.read('rc/maze.png').first
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
require 'tempfile'
f=Tempfile.open("24.zip")
point.length.times do |i|
  f.write( (img[point[i]].red/q).chr) if i.odd?
end
f.flush
require 'zipruby'
Zip::Archive.open(f.path){|z|
File.open("maze.jpg","wb"){|ex| ex.write z.fopen(z.locate_name("maze.jpg")).read}
}
f.close
"Apri maze.jpg"
end

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
s=File.read 'rc/mybroken.zip'
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
  img=Image.read('rc/zigzag.gif').first
  a=img.get_pixels 0,0,320,270
  atad=""
  q=QuantumRange+1
  q/=256
  a.each do |p| atad<< (p.red/q) end
  f=File.read('rc/zigzag.gif')[13...13+256*3]
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
  img=Image.read('rc/bell.png').first
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
  s=File.read 'rc/silence.txt'
  n=""
  s.each do |l| n<< (l.length-2).chr end
  require 'bz2'
  BZ2::bunzip2(n) =~ /I am (.+)!/
  $1
end

def l30 # http://www.pythonchallenge.com/pc/ring/yankeedoodle.html
  f=File.read "rc/yankeedoodle.csv"
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
  f=File.read('rc/mandelbrot.gif')
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
 s=solve("rc/warmup.txt")
 s=solve("rc/up.txt")
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

 img=Image.read("rc/beer2.png").first
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