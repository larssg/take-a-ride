module HomeHelper
  def street_view_image_url(lon, lat, heading)
    "http://maps.googleapis.com/maps/api/streetview?size=400x400&location=#{lon},#{lat}&heading=#{heading}&sensor=false&key=AIzaSyDMbu8xOPNiwE7o12PXfN3Ah6VqN6qNsQ4"
  end
end
