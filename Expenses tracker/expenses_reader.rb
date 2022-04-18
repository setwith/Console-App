require 'date'
require 'rexml/document'

curent_path = File.dirname(__FILE__)
file_name = curent_path + '/expenses.xml'

abort 'Вибач, хозяїн, файлик my_expenses.xml не знайдений.' unless File.exist?(file_name)

file = File.new(file_name)
doc = REXML::Document.new(file)

amount_by_day = {}                                             # пустий хеш, куди складемо всі трати по днях

# вибираєм в докі всі елементи в <expense> і проходимся по них
doc.elements.each('expenses/expense') do |item|
  loss_sum = item.attributes['amount'].to_i                     # скільки потратили
  loss_date = Date.parse(item.attributes['date'])               # коли витратили. Дата.парс створює із стрічки обєкт Data

  # якщо дати ще не було ініціалізуємо нулем
  amount_by_day[loss_date] ||= 0                                # a ||= b еквівалентно  if a == nil  a = b
  amount_by_day[loss_date] += loss_sum
end

file.close

sum_by_month = {} # пустий хеш, куди складемо всі трати по місяцях

amount_by_day.keys.sort.each do |key|                            # key.strftime("%B %Y") поверне однакову стрічку для всіх днів одного місяця
  sum_by_month[key.strftime('%B %Y')] ||= 0
  sum_by_month[key.strftime('%B %Y')] += amount_by_day[key]
end

current_month = amount_by_day.keys.sort[0].strftime('%B %Y')     # виводимо статистику. цикл по всіх місяцях починаючи з першого

puts "--------- #{current_month}, всього витрачено #{sum_by_month[current_month]} грн ---------"

amount_by_day.keys.sort.each do |key|                            # цикл по всіх днях
  if key.strftime('%B %Y') != current_month                      # якшо теперішній день належить настопному місяцю
    current_month = key.strftime('%B %Y')                        # то ми перейшли на наступний місяць і тепер він стане теперішній

    puts "--------- #{current_month}, всього витрачено #{sum_by_month[current_month]} грн ---------"
  end

  puts "#{key.day}: #{amount_by_day[key]} грн"                   # виводимо витрати за конкретний день
end
