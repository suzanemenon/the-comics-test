
class PortalController < ApplicationController

  def index
    ch_response = MarvelApiHelper.get_character_by_name('Black Widow')
    @character = Character.new(DataParserHelper.character(ch_response))
    
    st_response = MarvelApiHelper.get_story_by_character_id(@character.id)
    @story = Story.new(DataParserHelper.data_wrapper(st_response))

    @story_characters = []
    @story.characters.each do |character|
      ch_response = MarvelApiHelper.get_character_by_name(character.name)
      @story_characters << Character.new(DataParserHelper.character(ch_response)) 
    end
  end

end
