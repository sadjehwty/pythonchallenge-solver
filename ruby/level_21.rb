require 'rubygems'
require 'zlib'
require 'bz2'
out=File.open('../resources/package.pack').read
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
puts ret