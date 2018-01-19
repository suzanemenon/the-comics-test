module MarvelApiHelper
  CHARACTER_PATH = 'characters'

  def self.get_character_by_name(name)
    params = { path: CHARACTER_PATH, name: name }
    do_call(params)
  end

  def self.get_story_by_character_id(id)
    path = "#{CHARACTER_PATH}/#{id}/stories"
    params = { path: path, limit: 50 }
    do_call(params)
  end

private

  def self.do_call(params)
    response = MarvelApiService.new.call(params)
    JSON.parse(response)
  end
end