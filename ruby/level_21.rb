require 'zlib'
require 'rbzip2'
require 'tempfile'
out=File.open('../resources/package.pack').read
ret=""
loop do
 case out[0..1]
  when "x\234"
   out=Zlib::Inflate.inflate out
   ret<< " "
  when "BZ"
   t=Tempfile.new 'tmp'
   t.write out
   t.rewind
   bz2  = RBzip2::Decompressor.new t
   out=bz2.read
   t.close
   ret<< "#"
  else
   t=out[-2..-1].reverse
   if t=="BZ" or t=="x\234"
    out.reverse!
    ret<< "\n"
   else break end
 end
end
puts ret