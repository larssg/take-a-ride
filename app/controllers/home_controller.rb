require 'csv'

class HomeController < ApplicationController
  def index
    @rides = Ride.all
  end
end
