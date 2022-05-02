class Memo < Post
  def read_from_console  # запит вводу користувача
    puts 'Нова помітка (все, що пишете до стрічки \'end\'):'

    @text = []
    line = nil

    while line != 'end'
      line = STDIN.gets.chomp
      @text << line
    end

    @text.pop
  end

  def to_strings
    time_string = "Створено: #{@created_at.strftime('%Y.%m.%d, %h:%M:%S')}"
    @text.unshift(time_string)
  end

  def to_db_hash
    super.merge(
      {
        'text' => @text.join('\n\r')
      }
    )
  end
end
