# == Schema Information
# Schema version: 20090322184246
#
# Table name: mps
#
#  id                     :integer(4)      not null, primary key
#  full_name              :string(255)
#  person_id              :integer(4)
#  constituency           :string(255)
#  party                  :string(255)
#  written_questions_text :text
#  created_at             :datetime
#  updated_at             :datetime
#

require 'twfy'

class Mp < ActiveRecord::Base
  include Keys
  has_many :clouds
  
  validates_presence_of :full_name, :person_id
  validates_numericality_of :person_id, :only_integer => true
  validates_uniqueness_of :person_id

  def self.fetch_list
    RAILS_DEFAULT_LOGGER.info "Fetching MP list from TWFY"
    objs = self.twfy_client.mps
    mps = objs.collect do |obj| 
      self.find_or_create_from_twfy obj
    end
    mps.sort {|a,b| a.surname <=> b.surname}
  end

  def self.twfy_client
    Twfy::Client.new TWFY_API_KEY
  end

#  def self.from_postcode(postcode)
#    client = self.twfy_client
#    mp = client.mp :postcode => postcode
#    self.find_or_create_from_twfy obj
#  end

  # TWFY person_id
  def self.from_person_id(person_id)
    client = self.twfy_client
    mp = client.mp :id => person_id
    self.find_or_create_from_twfy mp[0]
  end

  def self.find_or_create_from_twfy(obj)
    self.find_by_person_id(obj.person_id) || self.create_from_twfy(obj)
  end

  def self.create_from_twfy(obj)
    mp = Mp.new
    name = obj.respond_to?(:full_name) ? obj.full_name : obj.name
    name = obj.name if name.blank?
    mp.full_name = name
    mp.person_id = obj.person_id
    mp.party = obj.party
    mp.constituency = obj.constituency.name
    mp.save!
    mp
  end

  def surname
    full_name.to_s.split(/ /)[-1]
  end

  def to_param
    "#{person_id}-#{full_name.gsub(/ /, '-')}"
  end

  def get_cloud
    cloud = self.clouds.last
    return clouds.create if cloud.nil? or written_question_text_has_changed?
    cloud
  end

  def text_for_cloud
    return written_questions_text unless written_questions_text.blank?
    self.written_questions_text = get_wrans
    save!
    self.written_questions_text
  end

  def get_wrans
    RAILS_DEFAULT_LOGGER.info "Calling TWFY.wrans for MP:#{full_name}"
    answers = twfy_client.wrans :person => person_id
    answers.rows.inject("") {|text, row| text << row['body']}
  end

  def written_question_text_has_changed?
    text = get_wrans
    if written_questions_text.blank? || self.written_questions_text != text
      self.written_questions_text = text
      save!
      return true
    else
      return false
    end
  end

  def twfy_client
    @twfy_client ||= Twfy::Client.new TWFY_API_KEY
  end

end
