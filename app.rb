require './restaurants'

class FoodFinderApp < Sinatra::Base

  configure :development do
    register Sinatra::Reloader
  end

  get "/" do
    craving = params['craving']
    location = params['location']
    variable = Restaurants.new(craving, location)
    if craving && location
      gf_places = variable.query_yelp["businesses"]
    end
    erb :index, locals: {gf_places: gf_places, location: location, craving: craving}
  end


end
