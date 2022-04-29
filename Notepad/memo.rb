class Memo < Post
  def read_from_console  # запит вводу користувача
    puts 'Нова помітка (все, що пишете до стрічки \'end\'):'

    @text = []
    line = nil

    while line != 'end' do
      line = STDIN.gets.chomp
      @text << line
    end

    @text.pop
  end

  def to_strings
    time_string = "Створено: #{@created_at.strftime('%Y.%m.%d, %h:%M:%S')}"
    return @text.unshift(time_string)
  end
end
