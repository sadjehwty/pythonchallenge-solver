puts "Challenge n.: "  
STDOUT.flush
if (n=gets.chomp) != 'all'
  load "level_#{n}.rb"
else
  34.times do |i|
    puts "#{i}° ---"
    load "level_#{i}.rb"
  end
end
