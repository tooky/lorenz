class Alphabet
  def initialize(characters)
    @alphabet = characters
  end

  def position(character)
    alphabet.index(character)
  end

  def shift_character(character, offset)
    alphabet[(position(character) + offset) % alphabet.length]
  end

  def first
    alphabet.first
  end

  private
  attr_reader :alphabet
end
