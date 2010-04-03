# http://www.pythonchallenge.com/pc/hex/decent.html
require 'rubygems'
require 'digest/md5'
require 'tempfile'
require 'zipruby'
s=File.read '../resources/mybroken.zip'
b=false
f="mybroken.gif"
s.length.times do |i|
 256.times do |j|
  r=s[0,i] + j.chr + s[i+1,s.length]
  if Digest::MD5.hexdigest(r) == 'bbb8b499a0eef99b52c7f13f4e78c24b'
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
puts "Open #{f} + \"boat\""