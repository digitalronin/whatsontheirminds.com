class Word
  include PhraseCoordinates

  attr_accessor :text, :value

  def initialize(text, value)
    @text = text
    @value = value
  end

  # distance from left in percentages
  def x
    (coordinates.x * 300).to_i
  end

  # distance from top in percentages
  def y
    (coordinates.y * 400).to_i
  end

  def size_factor
    (Math.log(value) / Math.log(3) + 1) / 2
  end

  private

  def coordinates
    @coordinates ||= phrase_coordinates
  end
end
