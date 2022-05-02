class Link < Post
  def initialize
    super
    @url = ''
  end

  def read_from_console  # запит вводу користувача
    puts 'Адреса посилання:'
    @url = STDIN.gets.chomp

    puts 'Що це за посилання?'
    @text = STDIN.gets.chomp
  end

  def to_strings
    time_string = "Створено: #{@created_at.strftime('%Y.%m.%d, %h:%M:%S')}"

    [@url, @text, time_string]
  end

  def to_db_hash
    super.merge(
      {
        'text' => @text,
        'url' => @url
      }
    )
  end
end
