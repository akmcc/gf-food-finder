require 'rubygems'
require 'oauth'
require 'json'
require 'cgi'
require 'sinatra'
require_relative 'secrets'

api_host = 'api.yelp.com'

consumer = OAuth::Consumer.new($CONSUMER_KEY, $CONSUMER_SECRET, {:site => "http://#{api_host}"})
access_token = OAuth::AccessToken.new(consumer, $TOKEN, $TOKEN_SECRET)

get "/" do
  @craving = params['craving']
  @location = params['location']
  erb :index
end

if !@craving.nil? && !@location.nil?
path = "/v2/search?term=#{CGI.escape(@craving)}&location=#{CGI.escape(@location)}&sort=2&category_filter=gluten_free&limit=10"

gf_places_json = access_token.get(path).body

gf_places = JSON.parse(gf_places_json)

gf_places["businesses"].each do |business|
  puts business["name"]
  puts business["rating"]
  puts business["location"]["city"]
  puts business["location"]["neighborhoods"]
  puts
  puts
end
end
