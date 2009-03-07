class TagExtractor
  include Keys

  API_SITE_URL = 'api.search.yahoo.com'
  API_PAGE_URL = '/ContentAnalysisService/V1/termExtraction';

  require 'net/http'
  require 'rexml/document'
  require 'uri'

  # public wrapper for the retrieve and parse process
  def self.extract(text)
    options = Hash.new
    options[:context] = text
    tag_xml = retrieve(options)

    parse(tag_xml)
  end
  
  private
  # pass the content to YTE for term extraction
  def self.retrieve(options)
    options['appid'] = YAHOO_API_KEY
    res = nil

    Net::HTTP.start(API_SITE_URL) do |http|
      req = Net::HTTP::Post.new(API_PAGE_URL) 
      req.form_data = options 
      res = http.request(req)
    end

    res.body
  end  
  
  # parse the XML returned from YTE into an array of tags
  def self.parse(xml)
    tags = Array.new
    doc = REXML::Document.new(xml) 
    doc.elements.each("*/Result") do |result| 
      tags << result.text
    end
    tags
  end
end

