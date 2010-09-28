class Message
  def initialize(message)
    @characters = message.scan(/./)
  end

  def cipher(&block)
    map_with_index(&block).join
  end

  def previous_character(index)
     characters[index - 1]
  end

  private
  def map_with_index(&block)
    @characters.each_with_index.map do | character, index |
      block.call(character, index)
    end
  end
  attr_reader :characters
end
