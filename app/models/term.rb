# == Schema Information
# Schema version: 20090322184246
#
# Table name: terms
#
#  id         :integer(4)      not null, primary key
#  text       :string(255)
#  value      :integer(4)
#  cloud_id   :integer(4)
#  created_at :datetime
#  updated_at :datetime
#

class Term < ActiveRecord::Base
  include PhraseCoordinates

  belongs_to :cloud

  OFFSET_FROM_TOP  = 160
  OFFSET_FROM_LEFT = 10

  # distance from left in percentages
  def x
    OFFSET_FROM_LEFT + (coordinates.x * 700).to_i
  end

  # distance from top in percentages
  def y
    OFFSET_FROM_TOP + (coordinates.y * 700).to_i
  end

  def colour
    phrase_colour
  end

  def size_factor
    (Math.log(value) / Math.log(3) + 1) * 1.5
  end

  private

  def coordinates
    @coordinates ||= phrase_coordinates
  end
end
