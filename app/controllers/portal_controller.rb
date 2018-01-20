
class PortalController < ApplicationController

  def index
    @error = nil
    ch_response = MarvelApiHelper.get_character_by_name('Spider-Man')
    return @error = ch_response['error'] if ch_response.key?('error')
    
    ch_response = DataParserHelper.character(ch_response)  
    return @error = 'Character not found' if ch_response.nil?
    @character = Character.new(ch_response)
    
    st_response = MarvelApiHelper.get_story_by_character_id(@character.id)
    return @error = st_response['error'] if st_response.key?('error')
    
    st_response = DataParserHelper.data_wrapper(st_response)
    return @error = 'No story found' if st_response['data']['results'].empty?
    @story = Story.new(st_response)

    @story_characters = []
    @story.characters.each do |character|
      ch_response = MarvelApiHelper.get_character_by_name(character.name)
      return @error = ch_response['error'] if ch_response.key?('error')

      ch_response = DataParserHelper.character(ch_response)
      return @error = 'Character not found' if ch_response.nil?

      @story_characters << Character.new(ch_response) 
    end    
  end
end
