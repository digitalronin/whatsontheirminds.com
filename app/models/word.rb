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

  private

  def coordinates
    @coordinates ||= phrase_coordinates
  end
end
