class Game
  def initialize(slovo)
    @letters = get_letters(slovo)
    @errors = 0
    @good_letters = []
    @bad_letters = []
    @status = 0
  end

  def get_letters(slovo)
    abort 'Для игры введите загаданное слово в качестве аргумента при запуске программы' if [nil, ''].include?(slovo)

    slovo.split('')
  end

  # Метод, возвращающий статус игры
  #  0 – игра активна
  # -1 – игра закончена поражением
  #  1 – игра закончена победой
  attr_reader :status

  def next_step(bukva)
    return if status == 1 || status == -1

    return if @good_letters.include?(bukva) || @bad_letters.include?(bukva)

    if @letters.include? bukva
      @good_letters << bukva

      status = 1 if @good_letters.uniq.sort == @letters.uniq.sort
    else
      @bad_letters << bukva
      @errors += 1

      @status = -1 if @errors >= 7
    end
  end

  def ask_next_letter
    puts 'Введите следующую букву'
    letter = ''
    letter = STDIN.gets.chomp while letter == ''

    next_step(letter)
  end

  attr_reader :letters, :errors, :good_letters

  def bad_lettrs
    @bad_letters
  end
end
