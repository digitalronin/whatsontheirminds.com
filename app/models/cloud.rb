class Cloud 
  attr_accessor :title, :words

  def initialize(params)
    @mp = params[:mp]
    @title = "#{@mp.full_name} Written Questions"
    tc = TextChunk.new text
    @words = tc.terms_with_counts
  end

  private

  def text
    @text ||= @mp.written_answer_text
  end

end
