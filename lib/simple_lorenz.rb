require 'message'
require 'alphabet'

class SimpleLorenz

  def initialize(wheel1, wheel2)
    @wheel1 = wheel1
    @wheel2 = wheel2
  end

  def encrypt(text)
    message = Message.new(text)
    message.remap_against(Message.new('')) do |encrypted_message, index|
      encrypted_message << encode_character(message, index)
    end.to_s
  end

  def decrypt(text)
    encrypted_message = Message.new(text)
    encrypted_message.remap_against(Message.new('')) do |message, index|
      message << decode_character(encrypted_message, message, index)
    end.to_s
  end

  class << self
    attr_reader :alphabet, :wheel2_multiplier, :wheel3_multiplier

    def [](alphabet, wheel2_multiplier, wheel3_multiplier)
      @alphabet = Alphabet.new(alphabet)
      @wheel2_multiplier = wheel2_multiplier
      @wheel3_multiplier = wheel3_multiplier
    end
  end

  private
  def offset(message, index)
    wheel1 + wheel2 + wheel3(message, index)
  end

  attr_reader :wheel1

  def wheel2
    @wheel2 * -wheel2_multiplier
  end

  def wheel3(message, index)
    alphabet.position(previous_character(message,index)) * wheel3_multiplier
  end

  def previous_character(message, index)
    return alphabet.first if index == 0
    message.previous_character(index)
  end

  def encode_character(message, index)
    alphabet.shift_character(message[index], offset(message, index))
  end

  def decode_character(encrypted_message, message, index)
    alphabet.shift_character(encrypted_message[index], -offset(message, index))
  end

  def alphabet
    self.class.alphabet
  end

  def wheel2_multiplier
    self.class.wheel2_multiplier
  end

  def wheel3_multiplier
    self.class.wheel3_multiplier
  end
end
