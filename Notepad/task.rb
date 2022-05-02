require 'date'

class Task < Post
  def initialize
    super
    @due_date = Time.now
  end

  def read_from_console  # запит вводу користувача
    puts 'Що потрібно зробити?'
    @text = STDIN.gets.chomp

    puts 'До якого числа потрібно зробити?'
    input = STDIN.gets.chomp

    @due_date = Date.parse(input)
  end

  def to_strings
    time_string = "Створено: #{@created_at.strftime('%Y.%m.%d, %h:%M:%S')}"
    deadline = "Крайній термін: #{@due_date}"

    [deadline, @text, time_string]
  end

  def to_db_hash
    super.merge(
      {
        'text' => @text,
        'due_date' => @due_date.to_s
      }
    )
  end
end
