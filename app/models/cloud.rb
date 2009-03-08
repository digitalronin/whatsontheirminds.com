class Cloud 
  attr_accessor :title, :words, :max_count, :min_count  # need these to derive the right CSS class

  BORING_TERMS = [
    'secretary of state',
    'secretary of state for the home department'
  ]

  # Yahoo term extractor likes sending back 'developme'. I have no
  # idea why. We replace it with 'development' later on.
  BROKEN_TERMS = {
    'developme' => 'development'
  }

  def initialize(params)
    @mp = params[:mp]
    @title = "#{@mp.full_name} Written Questions"
    @words = count_words
  end

  private

  def count_words
    @max_count = 0
    @min_count = 999

    rtn = []
    terms.sort.each do |term|
      RAILS_DEFAULT_LOGGER.debug "Counting: #{term}"
      value = text.downcase.split(%r[#{term}]).size
      @max_count = [ @max_count, value ].max
      @min_count = [ @min_count, value ].min
      rtn << Word.new(term, value)
    end
    rtn
  end

  def terms
    list = TagExtractor.extract(text) - BORING_TERMS
    BROKEN_TERMS.each do |term, replacement|
      if list.include? term
        list.delete term
        list << replacement
      end
    end
    list
  end

  def text
    @text ||= @mp.written_answer_text
  end

end
