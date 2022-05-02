require_relative 'post'
require_relative 'link'
require_relative 'task'
require_relative 'memo'

puts 'Привіт, я твій блокнот версія 2 + SQLite3'
puts 'Що хочеш записати?'

choices = Post.post_types.keys

choice = -1

until choice >= 0 && choice < choices.size
  choices.each_with_index do |type, index|
    puts "#{index}. #{type}"
  end

  choice = gets.to_i
end

entry = Post.create(choices[choice])

entry.read_from_console
id = entry.save_to_db

puts "Запис збережено! id = #{id}"
