class RidesController < ApplicationController
  def create
    ride = Ride.new
    ride.data = request.raw_post
    ride.save!

    head :ok
  end
end
