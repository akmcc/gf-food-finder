module YelpOauth

  def query_for_businesses
    create_consumer
    create_access_token
    create_path
    (JSON.parse(@access_token.get(@path).body))['businesses']
  end

  def create_consumer
    api_host = 'api.yelp.com'
    @consumer = OAuth::Consumer.new($CONSUMER_KEY, $CONSUMER_SECRET, {:site => "http://#{api_host}"})    
  end

  def create_access_token
    @access_token = OAuth::AccessToken.new(@consumer, $TOKEN, $TOKEN_SECRET)
  end

  def create_path
    @path = "/v2/search?term=#{CGI.escape(@craving)}&location=#{CGI.escape(@location)}&sort=2&category_filter=gluten_free&limit=10"
  end

end

class Restaurants
  include YelpOauth

  def initialize(craving, location)
    @craving = craving
    @location = location
  end

end