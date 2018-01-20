require 'rest-client'
require 'digest/md5'
require 'logger'

class MarvelApiService
  
  def call(params)
    logger = Logger.new(STDOUT)
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
    
    begin
      response = RestClient.get "#{api_url}#{path}", { params: params }
    rescue RestClient::ExceptionWithResponse => e
      case e.http_code
      when 401
        logger.warn("Code: #{e.response.code} | Message: #{e.response.message}")
        response = { error: e.response.message }.to_json
      when 404
        logger.warn("Code: #{e.response.code} | Message: #{e.response.message}")
        response = { error: e.response.message }.to_json
      when 409
        logger.warn("Code: #{e.response.code} | Message: #{e.response.message}")
        response = { error: e.response.message }.to_json
      else
        logger.warn("Code: #{e.response.code} | Message: #{e.response.message}")
        response = { error: e.response.message }.to_json
      end
    else
      logger.info('Authentication successful!')
      return response
    end
  end

private

  def generate_md5_hash(timestamp, private_key, public_key)
    Digest::MD5.hexdigest(timestamp+private_key+public_key)
  end

end