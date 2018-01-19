require 'rest-client'
require 'digest/md5'

class MarvelApiService

  def call(params)
    credentials = YAML::load(File.open(Rails.root.join('config/config.yml')))
    api_url = credentials['marvel_api_url']
    path = params.delete(:path)
    
    timestamp = Time.now.to_i.to_s 
    params[:ts] = timestamp
    public_key = credentials['marvel_api_public_key']
    params[:apikey] = public_key
    private_key = credentials['marvel_api_private_key']
    hash = generate_md5_hash(timestamp, private_key, public_key)
    params[:hash] = hash
  
    response = RestClient.get api_url+path, { params: params }
  end

private

  def generate_md5_hash(timestamp, private_key, public_key)
    Digest::MD5.hexdigest(timestamp+private_key+public_key)
  end

end