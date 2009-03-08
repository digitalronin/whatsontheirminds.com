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

  def phrase_colour
    md5 = MD5::hexdigest(@text)
    r = md5[0,10].hex % 255
    g = md5[11,20].hex % 255
    b = md5[21,31].hex % 255
    "%s%s%s" % [
      r.to_s(16),
      g.to_s(16),
      b.to_s(16)
    ]
  end

end
