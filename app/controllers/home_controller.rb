require 'csv'

class HomeController < ApplicationController
  def index
  
  end

  def show
    ride = Ride.find(params[:id])

    @data = []
    CSV.foreach(ride.data, headers: true) do |row|
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
