class ResultPrinter
  def print_status(game)
    cls
    puts "Слово: #{get_word_for_print(game.letters, game.good_letters)}"
    puts "Ошибки: #{game.bad_lettrs.join(', ')}"

    if game.status == -1
      puts 'Вы проиграли :('
      puts 'Загаданное слово было: ' + game.letters.join('')
    elsif game.status == 1
      puts 'Поздравляем, вы выиграли!'
    else
      puts 'У вас осталось ошибок: ' + (7 - game.errors).to_s
    end
  end

  def cls
    system 'clear'
  end

  def get_word_for_print(letters, good_letters)
    result = ''

    letters.each do |item|
      result += if good_letters.include?(item)
                  item + ' '
                else
                  '__ '
                end
    end

    result
  end
end
