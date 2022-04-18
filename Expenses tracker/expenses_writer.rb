require 'date'
require 'rexml/document'

puts 'На что потратили деньги?'
expense_text = STDIN.gets.chomp

puts 'Сколько потратили?'
expense_amount = STDIN.gets.chomp.to_i

puts 'Укажите дату траты в формате ДД.ММ.ГГГГ, например 12.05.2003 (пустое поле - сегодня)'
date_input = STDIN.gets.chomp

expense_date = nil

# якщо нічого не ввів - сьогоднішня дата
if date_input == ''
  expense_date == Date.today
else
  begin
    expense_date = Date.parse(date_input)
  rescue StandardError => e # якшо дата написана невірно робимо виключення і використовуєм сьогоднішню дату
    expense_date == Date.today
  end
end

puts 'В какую категорию занести трату'
expense_category = STDIN.gets.chomp

# прочитаємо наявний вміст файлу і позначимо його XML структуру в змінну doc
curent_path = File.dirname(__FILE__)
file_name = curent_path + '/expenses.xml'

file = File.new(file_name, 'r')
doc = nil

begin
  doc = REXML::Document.new(file)
rescue REXML::ParseException => e # якшо парсер помилився при читанні файлу
  puts 'XML файл похоже битый :('
  abort e.message
end

file.close

# добавимо трату в XML через змінну doc. Для цього знайдемо корневий елемент expenses
expenses = doc.elements.find('expenses').first

expense = expenses.add_element 'expense', {
  'amount' => expense_amount,
  'category' => expense_category,
  'date' => expense_date
}

expense.text = expense_text

file = File.new(file_name, 'w')
doc.write(file, 2)
file.close

puts 'Информация успешно сохранена'
