# http://www.pythonchallenge.com/pc/hex/bin.html
require 'rubygems'
require 'base64'
f=Base64.decode64 File.read('../resources/19.eml')
require 'audiofile'
a=AudioFile.new( "19.wav", "w" )
a.rate=22050
a.channels=1
a.sample_format=AudioFile::UNSIGNED
a.bits=8
a.write f
a.flush
a.close
puts "Open 19.wav"