class TextChunk
  attr_accessor :body

  BORING_TERMS = [
    'secretary of state',
    'secretary of state for the home department'
  ]

  # Yahoo term extractor likes sending back 'developme'. I have no
  # idea why. We replace it with 'development' later on.
  BROKEN_TERMS = {
    'developme' => 'development'
  }

  def initialize(body)
    @body = body
  end

  def terms
    list = TagExtractor.extract(body) - BORING_TERMS
    BROKEN_TERMS.each do |term, replacement|
      if list.include? term
        list.delete term
        list << replacement
      end
    end
    list
  end

end
