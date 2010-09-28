class SimpleLorenz

  CHARACTER_SET = [
    "a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p",
    "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", ".", ",", "?", "!", " "
  ]

  class Message
    def initialize(message)
      @characters = message.scan(/./)
    end

    def cipher(&block)
      @characters.each_with_index.map do | character, index | 
        block.call(character, index)
      end.join
    end

    def previous_character(index)
      if index == 0
        previous_character = CHARACTER_SET.first
      else
        previous_character = characters[index - 1]
      end
    end

    private
    attr_reader :characters
  end

  def cipher(message)
    message = Message.new(message)
    message.cipher do |character, index|
      offset_character(character, offset(message, index))
    end
  end

  def offset(message, index)
    (position(message.previous_character(index)) * 2)
  end

  def position(character)
    CHARACTER_SET.index(character)
  end

  def offset_character(character, offset)
    CHARACTER_SET[(position(character) + offset) % CHARACTER_SET.length]
  end
end
