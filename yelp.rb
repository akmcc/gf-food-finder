# $CONSUMER_KEY = ENV['CONSUMER_KEY']
# $CONSUMER_SECRET = ENV['CONSUMER_SECRET']
# $TOKEN = ENV['TOKEN']
# $TOKEN_SECRET = ENV['TOKEN_SECRET']

module YelpOauth

  def query_for_businesses
    create_consumer
    create_access_token
    create_path
    (JSON.parse(@access_token.get(@path).body))['businesses']
  end

  def create_consumer
    api_host = 'api.yelp.com'
    @consumer = OAuth::Consumer.new(ENV['CONSUMER_KEY'], ENV['CONSUMER_SECRET'], {:site => "http://#{api_host}"})    
  end

  def create_access_token
    @access_token = OAuth::AccessToken.new(@consumer, ENV['TOKEN'], ENV['TOKEN_SECRET'])
  end

  def create_path
    @path = "/v2/search?term=#{CGI.escape(@craving)}&location=#{CGI.escape(@location)}&sort=2&category_filter=gluten_free&limit=10"
  end

end