require ::File.expand_path('../environment', __FILE__)
require 'bundler'
Bundler.require

require './app'

run FoodFinderApp