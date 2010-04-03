# http://www.pythonchallenge.com/pc/ring/guido.html
require 'rubygems'
require 'bz2'
s=File.read '../resources/silence.txt'
n=""
s.each do |l| n<< (l.length-2).chr end
BZ2::bunzip2(n) =~ /I am (.+)!/
puts $1