# http://www.pythonchallenge.com/pc/def/channel.html
require 'rubygems'
require 'zipruby'
i="90052"
f=""
Zip::Archive.open("../resources/channel.zip"){ |file|
  begin
    l=file.locate_name "#{i}.txt"
    f<< file.get_fcomment(l)
    s=file.fopen(l).read
    i= s=~ /Next nothing is (\d+)/ ? $1:nil
  end until i.nil?
}
puts f