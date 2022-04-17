head_path = './data/foreheads.txt'
eyes_path = './data/eyes.txt'
noses_path = './data/noses.txt'
mouths_path = './data/mouths.txt'

if File.exist?(head_path)
  f = File.new(head_path, 'r:UTF-8')
  for_head = f.readlines.sample
  f.close
else
  puts 'голова не найдена'
end

if File.exist?(eyes_path)
  f = File.new(eyes_path, 'r:UTF-8')
  for_eyes = f.readlines.sample
  f.close
else
  puts 'глаза не найдены'
end

if File.exist?(noses_path)
  f = File.new(noses_path, 'r:UTF-8')
  for_nose = f.readlines.sample
  f.close
else
  puts 'нос не найден'
end

if File.exist?(mouths_path)
  f = File.new(mouths_path, 'r:UTF-8')
  for_mouth = f.readlines.sample
  f.close
else
  puts 'рот не найден'
end

current_path = File.dirname(__FILE__)

time = Time.now
file_time = time.strftime('%Y-%m-%d;__%H:%M')

f = File.new(current_path + '/face' + file_time, 'w')
f.puts(for_head)
f.puts(for_eyes)
f.puts(for_nose)
f.puts(for_mouth)
f.close
