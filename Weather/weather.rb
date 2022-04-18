require 'net/http'
require 'uri'
require 'rexml/document'
require 'cgi'

CLOUDINESS = %w[туман ясно малохмарно хмарно похмуро].freeze

# створимо обєкт-адрес, де лежить погода в Черкасах
uri = URI.parse('https://xml.meteoservice.ru/export/gismeteo/point/2931.xml')

# відправляємо запит по адресу і зберігаємо відповідь в змінну
response = Net::HTTP.get_response(uri) # puts response.body - так можна вивести вміст відповіді сервера

# парсим отриманий xml
doc = REXML::Document.new(response.body)

time = Time.now

# збираєм параметри
city_name = CGI.unescape(doc.root.elements['REPORT/TOWN'].attributes['sname'])

# достаєм з xml прогноз на найближчий день
forecast = doc.root.elements['REPORT/TOWN/FORECAST']

# записуєм мінімальнке і максимальне значення температури
min_temp = forecast.elements['TEMPERATURE'].attributes['min']
max_temp = forecast.elements['TEMPERATURE'].attributes['max']

# записуєм показнк атмосферного явища і співставляємо його з масивом CLOUDINESS
clouds_index = forecast.elements['PHENOMENA'].attributes['cloudiness'].to_i
clouds = CLOUDINESS[clouds_index]

puts
puts time
puts city_name
puts "Температура від #{min_temp} до #{max_temp}C"
puts clouds
