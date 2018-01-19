class Character

  attr_accessor :id, :name, :thumbnail, :resource_uri

  def initialize(character_params)
    @id = character_params['id']
    @name = character_params['name']
    @thumbnail = format_thumbnail(character_params['thumbnail'])
    @resource_uri = character_params['resource_uri']
  end

private

  def format_thumbnail(thumbnail)
    return if thumbnail.nil?
    "#{thumbnail['path']}.#{thumbnail['extension']}"
  end
end