require 'pony'
require 'io/console'

puts 'Введите адрес вашей почты:'
my_mail = STDIN.gets.chomp

puts "Введите пароль от вашей почты #{my_mail} для отправки письма:"
password = STDIN.noecho(&:gets).chomp

puts 'Кому отправить письмо? Введите адрес:'
send_to = STDIN.gets.chomp

puts 'Какая тема письма?'
subject = STDIN.gets.chomp

puts 'Что написать в письме?'
body = STDIN.gets.chomp

begin
  Pony.mail(
    subject: subject,
    body: body,
    to: send_to,
    from: my_mail,
    via: :smtp,
    via_options: {
      address: 'smtp.gmail.com',
      port: '587',
      enable_starttls_auto: true,
      user_name: my_mail,
      password: password,
      authentication: :plain
    }
  )
  puts 'Письмо отправлено!'
rescue SocketError
  puts 'Не могу соединиться с сервером. '
rescue Net::SMTPSyntaxError => e
  puts 'Вы некорректно задали параметры письма: ' + e.message
rescue Net::SMTPAuthenticationError => e
  puts 'Неправильный пароль, попробуйте еще: ' + e.message
ensure
  puts 'Мы постарались отправить письмо.'
end
