require 'json'
require 'cgi'
require 'sinatra'
require 'sinatra/reloader'
require_relative '../../secrets'




get "/" do
  @craving = params['craving']
  @location = params['location']
  if !@craving.nil? && !@location.nil?
    gf_places = get_businesses["businesses"]
  end
  erb :index, :locals => {:gf_places => gf_places}
end

def get_businesses
  
    path = "/v2/search?term=#{CGI.escape(@craving)}&location=#{CGI.escape(@location)}&sort=2&category_filter=gluten_free&limit=10"
    
    api_host = 'api.yelp.com'

    consumer = OAuth::Consumer.new($CONSUMER_KEY, $CONSUMER_SECRET, {:site => "http://#{api_host}"})
    @access_token = OAuth::AccessToken.new(consumer, $TOKEN, $TOKEN_SECRET)

   JSON.parse(@access_token.get(path).body)
   
  
end
