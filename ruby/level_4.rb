# http://www.pythonchallenge.com/pc/def/linkedlist.php
require 'rubygems'
require 'net/http'
i="12345"
begin
  res=Net::HTTP.start("www.pythonchallenge.com",80) { |http|
    http.get("/pc/def/linkedlist.php?nothing="+i)}
  j=i
  i= (res.body=~/and the next nothing is (\d+)/)?$1:nil
end while i
i=(j.to_i/2).to_s
begin
  res=Net::HTTP.start("www.pythonchallenge.com",80) { |http|
    http.get("/pc/def/linkedlist.php?nothing="+i)}
  i= (res.body=~/and the next nothing is (\d+)/)?$1:nil
end while i
puts res.body