class Cloud 
  attr_accessor :title, :words, :max_count, :min_count  # need these to derive the right CSS class

  def initialize(params)
    @mp = params[:mp]
    @title = "#{@mp.full_name} Written Questions"
    @words = count_words
  end

  private

  def count_words
    @max_count = 0
    @min_count = 999

    tc = TextChunk.new text

    rtn = []
    tc.terms.sort.each do |term|
      value = tc.body.downcase.split(%r[#{term}]).size
      RAILS_DEFAULT_LOGGER.debug "Counting: #{term}, #{value}"
      @max_count = [ @max_count, value ].max
      @min_count = [ @min_count, value ].min
      word = Word.new(term, value)
      rtn << word
    end
    # Return words in descending order of occurrences, so that the 
    # biggest words are drawn on the page first, with smaller words
    # on top, to make it easier to read the tag cloud
    rtn.sort {|a,b| a.value <=> b.value}.reverse
  end

  def text
    @text ||= @mp.written_answer_text
  end

end
