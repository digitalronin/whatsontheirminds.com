require 'twfy'

class Mp
  include Keys

  attr_accessor :full_name, :person_id, :constituency, :party

  def self.fetch_list
    objs = self.twfy_client.mps
    RAILS_DEFAULT_LOGGER.debug objs.inspect
    mps = objs.collect do |obj| 
      self.instantiate obj
    end
    mps.sort {|a,b| a.surname <=> b.surname}
  end

  def self.twfy_client
    Twfy::Client.new TWFY_API_KEY
  end

  def self.from_postcode(postcode)
    client = self.twfy_client
    mp = client.mp :postcode => postcode
    self.instantiate obj
  end

  # TWFY person_id
  def self.from_person_id(person_id)
    client = self.twfy_client
    mp = client.mp :id => person_id
    self.instantiate mp[0]
  end

  def self.instantiate(obj)
    mp = Mp.new
    mp.full_name = obj.respond_to?(:full_name) ? obj.full_name.to_s : obj.name.to_s
    mp.person_id = obj.person_id
    mp.party = obj.party
    mp.constituency = obj.constituency.name
    mp
  end

  def surname
    RAILS_DEFAULT_LOGGER.debug "SURNAME: #{@full_name}"
    @full_name.split(/ /)[-1]
  end

  def to_param
    "#{person_id}-#{@full_name.gsub(/ /, '-')}"
  end

  def cloud
    @cloud ||= Cloud.new(:mp => self)
  end

  def written_answer_text
    answers = twfy_client.wrans :person => person_id
    answers.rows.inject("") {|text, row| text << row['body']}
  end

  private

  def twfy_client
    @twfy_client ||= Twfy::Client.new TWFY_API_KEY
  end

end
