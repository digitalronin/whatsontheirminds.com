# == Schema Information
# Schema version: 20090322184246
#
# Table name: clouds
#
#  id         :integer(4)      not null, primary key
#  mp_id      :integer(4)
#  created_at :datetime
#  updated_at :datetime
#

class Cloud < ActiveRecord::Base
  belongs_to :mp
  has_many :terms

  def initialize(params)
    super params
    tc = TextChunk.new mp.text_for_cloud
    self.terms = tc.terms_with_counts
  end

  def title
    "#{mp.full_name} Written Questions"
  end

end
