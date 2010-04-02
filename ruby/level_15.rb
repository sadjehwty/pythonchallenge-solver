# http://www.pythonchallenge.com/pc/return/uzi.html
require 'date'
i=2006
n=0
out=0
while n<3
  if Date.civil(i,1,26).wday==1
    n+=1
    out=i
  end
  i-=10
end
puts "Search: 27/1/#{out}"