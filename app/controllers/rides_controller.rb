class RidesController < ApplicationController
  def create
    ride = Ride.new
    ride.data = request.raw_post
    ride.save!

    head :ok
  end

  def show
    ride = Ride.find(params[:id])

    @data = []
    CSV.parse(ride.data, headers: true) do |row|
      @data << {
        timestamp: row[0] + ' ' + row[1],
        event: row[2],
        lat: row[3],
        lon: row[4],
        heading: row[5]
      }
    end
    end
end
