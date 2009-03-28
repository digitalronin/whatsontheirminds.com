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

  validate :has_some_terms

  def initialize(params = nil)
    super params
    tc = TextChunk.new mp.text_for_cloud
    self.terms = tc.terms_with_counts
  end

  def title
    "#{mp.full_name} Written Questions"
  end

  private

  # Sometimes the Yahoo! Term Extractor gives back nothing.
  # Don't save the cloud if that happens.
  def has_some_terms
    if self.terms.size == 0
      errors.add :terms, "must not be empty"
    end
  end

end
