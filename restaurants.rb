require_relative "./yelp"

class Restaurants
  include YelpOauth

  def initialize(craving, location)
    @craving = craving
    @location = location
  end

end