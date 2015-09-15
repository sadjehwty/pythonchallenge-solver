# http://www.pythonchallenge.com/pc/ring/guido.html
require 'tempfile'
require 'rbzip2'
s=File.open('../resources/silence.txt', encoding: 'ascii-8bit').read
n=""
s.split("\n").each do |l| n<< (l.size).chr.force_encoding(Encoding::ASCII_8BIT) end
n << 0.chr
t=Tempfile.new 'tmp'
t.write n
t.rewind
bz2  = RBzip2::Decompressor.new t
bz2.read =~ /I am (.+)!/
t.close
puts $1