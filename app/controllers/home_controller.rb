require 'csv'

class HomeController < ApplicationController
  def index
    @data = []
    CSV.foreach(Rails.root.join('data', 'event_data.csv'), headers: true) do |row|
      @data << {
        timestamp: row[0] + ' ' + row[1],
        event: row[2],
        lat: row[3],
        lon: row[4]
      }
    end
  end
end
