# http://www.pythonchallenge.com/pc/def/integrity.html
require 'tempfile'
require 'rbzip2'
a={'user'=>"BZh91AY&SYA\xaf\x82\r\x00\x00\x01\x01\x80\x02\xc0\x02\x00 \x00!\x9ah3M\x07<]\xc9\x14\xe1BA\x06\xbe\x084",
   'pwd'=>"BZh91AY&SY\x94$|\x0e\x00\x00\x00\x81\x00\x03$ \x00!\x9ah3M\x13<]\xc9\x14\xe1BBP\x91\xf08"}
a.each_key do |k|
  t=Tempfile.new 'tmp'
  t.write a[k]
  t.rewind
  bz2  = RBzip2::Decompressor.new t
  a[k]=bz2.read
  t.close
end
p a