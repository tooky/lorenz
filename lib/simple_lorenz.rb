require 'characters'

class SimpleLorenz

  def initialize(wheel1, wheel2)
    @wheel1 = wheel1
    @wheel2 = wheel2
  end

  def encrypt(text)
    message = Characters.new(text)
    message.remap do |character, index|
      offset_character(character, offset(message, index))
    end
  end

  def decrypt(text)
    encrypted_message = Characters.new(text)
    message = ''

    encrypted_message.remap do |character, i|
      offset_character(character, -offset(Characters.new(message), i)).
        tap { |c| message << c }
    end
  end

  class << self
    attr_reader :alphabet, :multiplier

    def [](alphabet, multiplier)
      @alphabet = alphabet
      @multiplier = multiplier
    end
  end

  private

  attr_reader :wheel1

  def wheel2
    @wheel2 * -multiplier
  end

  def alphabet
    self.class.alphabet
  end

  def multiplier
    self.class.multiplier
  end

  def offset(message, index)
    wheel1 + wheel2 + wheel3(message, index)
  end

  def wheel3(message, index)
    position(previous_character(message,index)) * multiplier
  end

  def position(character)
    alphabet.index(character)
  end

  def offset_character(character, offset)
    alphabet[(position(character) + offset) % alphabet.length]
  end

  def previous_character(message, index)
    return alphabet.first if index == 0
    message.previous_character(index)
  end
end
