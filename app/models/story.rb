class Story

  attr_accessor :id, :title, :description, :thumbnail, :characters, :attribution_text

  def initialize(params)
    attribution_text = params['attributionText']
    count = params['data']['count']
    story_params = params['data']['results'][rand(count)]

    @id = story_params['id']
    @title = story_params['title']
    @description = story_params['description']
    @thumbnail = format_thumbnail(story_params['thumbnail'])
    @characters = characters_list(story_params['characters']['items'])
    @attribution_text = attribution_text
  end

private

  def format_thumbnail(thumbnail)
    return if thumbnail.nil?
    thumbnail['path']+'.'+thumbnail['extension']
  end

  def characters_list(characters)
    characters_list = []
    characters.each do |character|
      characters_list << Character.new(character)
    end
    characters_list
  end
end