class Post

  def self.post_types
    [Memo, Task, Link]
  end

  def self.create(type_index)
    return post_types[type_index].new
  end

  def initialize
    @created_at = Time.now
    @text = nil
  end

  def read_from_console  # запит вводу користувача
    # todo
  end

  def to_strings
    # todo
  end

  def save
    file = File.new(file_path, 'w')

    to_strings.each do |item|
      file.puts(item)
    end

    file.close
  end

  def file_path
    current_path = File.dirname(__FILE__)
    file_name = @created_at.strftime("#{self.class.name}_%Y-%m-%d_%h-%M-%S.txt")

    current_path + '/' + file_name
  end
end
