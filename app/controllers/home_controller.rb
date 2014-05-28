require 'csv'

class HomeController < ApplicationController
  def index
    @data = []
    CSV.foreach(Rails.root.join('data', 'event_data.csv'), headers: true) do |row|
      @data << {
        timestamp: row[0] + ' ' + row[1],
        event: row[2],
        lon: row[3],
        lat: row[4]
      }
    end
  end
end
