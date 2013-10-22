require 'rubygems'
require 'oauth'
require 'json'
require 'cgi'
require 'sinatra'
require 'sinatra/reloader'
require_relative 'secrets'




get "/" do
  craving = params['craving']
  location = params['location']
  gf_places = get_businesses(craving, location)
  erb :index, :locals => {:gf_places => gf_places}
end

def get_businesses(craving, location)
  if !craving.nil? && !location.nil?
    path = "/v2/search?term=#{CGI.escape(craving)}&location=#{CGI.escape(location)}&sort=2&category_filter=gluten_free&limit=10"
    
    api_host = 'api.yelp.com'

    consumer = OAuth::Consumer.new($CONSUMER_KEY, $CONSUMER_SECRET, {:site => "http://#{api_host}"})
    @access_token = OAuth::AccessToken.new(consumer, $TOKEN, $TOKEN_SECRET)

   JSON.parse(@access_token.get(path).body)
   
  end
end

##this oauth process will not work due to token expiring... ugh.