require 'json'
require 'cgi'
require './secrets'

class Restaurants

  def initialize(craving, location)
    @craving = craving
    @location = location
  end

  def query_yelp
    path = "/v2/search?term=#{CGI.escape(@craving)}&location=#{CGI.escape(@location)}&sort=2&category_filter=gluten_free&limit=10"
    api_host = 'api.yelp.com'
    consumer = OAuth::Consumer.new($CONSUMER_KEY, $CONSUMER_SECRET, {:site => "http://#{api_host}"})
    @access_token = OAuth::AccessToken.new(consumer, $TOKEN, $TOKEN_SECRET)
    JSON.parse(@access_token.get(path).body)  
  end

end