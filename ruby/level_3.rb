# http://www.pythonchallenge.com/pc/def/equality.html
s=File.read '../resources/3.txt'
temp=""
s.scan(/[a-z][A-Z]{3}([a-z])[A-Z]{3}[a-z]/).each do |l|
  temp<< l[0]
end
puts temp