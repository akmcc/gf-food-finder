
class FoodFinderApp < Sinatra::Base

  configure :development do
    register Sinatra::Reloader
  end

  get "/" do
    @display_results = false
    erb :index
  end

  post "/" do
    craving = params['craving']
    location = params['location']
    @display_results = true
    gf_places = Restaurants.new(craving, location).query_for_businesses
    erb :index, locals: {gf_places: gf_places, location: location, craving: craving}
  end
end
