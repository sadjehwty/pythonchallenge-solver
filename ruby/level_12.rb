# http://www.pythonchallenge.com/pc/return/evil.html
s=File.read '../resources/evil2.gfx'
out=[]
5.times do |i|
  out[i]=[]
end
s.length.times do |i|
  out[i.modulo(5)]<< s[i]
end
5.times do |i|
  File.open("12_#{i}.png","w+") do |f|
    out[i].each do |c|
      f.write(c.chr)
    end
  end
end
puts "Open 12_*.png"