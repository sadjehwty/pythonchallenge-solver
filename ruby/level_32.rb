# http://www.pythonchallenge.com/pc/rock/arecibo.html
require 'rubygems'
require 'gecoder' 
include Gecode::Mixin
class Nonogram 
  def initialize(row_rules, col_rules)
    filled_is_an bool_var_matrix(row_rules.size, col_rules.size)
    row_rules.each_with_index do |row_rule, i| 
     filled.row(i).must.match parse_regex(row_rule)
    end
    col_rules.each_with_index do |col_rule, i|
      filled.column(i).must.match parse_regex(col_rule)
    end
    branch_on filled, :variable => :none, :value => :max
  end
  def parse_regex(a)
    r = [repeat(false)]
    a.each_with_index do |e,i| 
      r << repeat(true,e,e)
      r << at_least_once(false)  if i < a.length-1
    end
    r << repeat(false)
    r
  end
end

def solve s
  a=File.read(s).to_a[4..-1]
  enne=[[],[]]
  i=0
  a.each do |line|
    line.chomp!
    if line=~/#/
      i+=1
      next
    end
    next if line.length<1
    line=line.split(/\s/)
    temp=[]
    line.each do |n| temp<< n.to_i end
    enne[i]<< temp
  end
  row_rules = enne[0]
  col_rules = enne[1]
  nonogram = Nonogram.new(row_rules, col_rules)
  num_solutions = 0
  ret=""
  nonogram.each_solution do |s| 
    num_solutions += 1
    s.filled.values.enum_slice(s.filled.column_size).each do |row|
      ret<< row.map{ |filled| filled ? "#" : " " }.join + "\n"
    end
  end
  ret
end
['warmup','up'].each do |s|
  File.open("#{s}.txt","w"){|f| f.write solve("../resources/#{s}.txt")}
end
"free speech, not free beer"=~/free speech, not free (.+)/
puts $1