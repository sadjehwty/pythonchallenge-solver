# http://www.pythonchallenge.com/pc/ring/guido.html
require 'tempfile'
require 'rbzip2'
s=File.read '../resources/silence.txt'
n=""
s.each do |l| n<< (l.length-2).chr end
t=Tempfile.new 'tmp'
t.write n
t.rewind
bz2  = RBzip2::Decompressor.new t
bz2.read =~ /I am (.+)!/
t.close
puts $1