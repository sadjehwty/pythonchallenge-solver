# http://www.pythonchallenge.com/pc/def/ocr.html
s=File.read '../resources/2.txt'
temp=""
s.size.times do |i|
  temp<< s[i,1] if s.count(s[i,1])<20
end
puts temp