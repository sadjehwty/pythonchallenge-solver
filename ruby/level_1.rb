# http://www.pythonchallenge.com/pc/def/274877906944.html
def f s
  t=""
  s.size.times do |i|
    c=s[i].chr
    if c=~/\w/
      t<< c.next.next
    else
      t<< c
    end
  end
  t.gsub("aa","a").gsub("ab","b")
end
s="g fmnc wms bgblr rpylqjyrc gr zw fylb. rfyrq ufyr amknsrcpq ypc dmp. bmgle gr gl zw fylb gq glcddgagclr ylb rfyr'q ufw rfgq rcvr gq qm jmle. sqgle qrpgle.kyicrpylq() gq pcamkkclbcb. lmu ynnjw ml rfc spj."
puts f(s) + " => " + f("map")