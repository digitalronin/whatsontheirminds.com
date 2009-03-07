module PhraseCoordinates
  require 'md5'

  class Coordinate < Struct.new(:x, :y)
  end

  MAX_COORDINATE_VALUE = "ffff".hex.to_f

  def phrase_coordinates
    md5 = MD5::hexdigest(@text)
    x = md5[0, 4].hex / MAX_COORDINATE_VALUE
    y = md5[4, 4].hex / MAX_COORDINATE_VALUE
    Coordinate.new(x, y)
  end
end
