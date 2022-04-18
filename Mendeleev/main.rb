require 'json'

file = File.read('elements.json')
elements = JSON.parse(file)

puts "У нас всего элементов: #{elements.keys.size}"
puts elements.keys

puts 'О каком элементе хотите узнать?'
element_key = gets.chomp

if elements.has_key?(element_key)
  element = elements[element_key]
  puts "Порядковый номер: #{element['number']}"
  puts "Название: #{element['name']}"
  puts "Первооткрыватель: #{element['discoverer']}"
  puts "Плотность: #{element['density']}, г/см³"
else
  puts 'Извините, про такой элемент мы еще не знаем.'
end
