# http://www.pythonchallenge.com/pc/return/balloons.html
require 'rubygems'
require 'zlib'
a=""
Zlib::GzipReader.open '../resources/deltas.gz' do |g| a=g.read end
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
 ret<< "Open #{j.path}\n"
 j.close
end
puts ret