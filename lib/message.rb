class Message
  def initialize(message)
    @characters = message.scan(/./)
  end

  def remap_against(text, &block)
    characters.each_index.inject(text) do |message, index|
      block.call(message, index)
    end
  end

  def previous_character(index)
    characters[index - 1]
  end

  def [](index)
    characters[index]
  end

  def <<(character)
    characters << character
    self
  end

  def to_s
    characters.join
  end

  private
  attr_reader :characters
end
