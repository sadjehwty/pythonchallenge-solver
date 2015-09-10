# http://www.pythonchallenge.com/pc/hex/bin.html
require 'base64'
require 'ruby-audio'
f=Base64.decode64(File.read('../resources/19.eml')).force_encoding Encoding::ASCII_8BIT
b=RubyAudio::Buffer.new 'int', f.size
f.bytes.each_with_index do |c,i|
  b[i]=c.ord
end
i=RubyAudio::SoundInfo.new channels: 1, samplerate: 22050, format: RubyAudio::FORMAT_RAW|RubyAudio::FORMAT_PCM_U8
RubyAudio::Sound.open "19.wav", "w", i do |a| 
  a.write b
end
puts "Open 19.wav"

