# http://www.pythonchallenge.com/pc/return/bull.html
@rin=[/^333/,/^222/,/^111/,/^33/,/^22/,/^11/,/^3/,/^2/,/^1/]
@rout=["33","32","31","23","22","21","13","12","11"]
def rn n
  3-n/3
end
def reg s
  return s if s==""
  ret=""
  str=s
  while str.length>0
    @rin.length.times do |i|
      if str=~@rin[i]
        ret<< @rout[i]
        str=str[rn(i)..str.length]
        break
      end
    end
  end
  ret
end
def f(n,s)
  k=s
  n.times do
    k=reg(k)
  end
  k
end
puts f(30,"1").length