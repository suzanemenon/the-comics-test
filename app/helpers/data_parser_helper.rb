module DataParserHelper

  def self.data_wrapper(content)
    content
  end

  def self.data_container(content)
    content['data']
  end

  def self.character(content)
    content['data']['results'][0]
  end

end