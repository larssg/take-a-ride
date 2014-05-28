app = angular.module('takearide', [])

app.controller 'HomeController', ['$scope', '$window', ($scope, $window) ->
  $scope.data = $window.data
  bounds = null
  map = null
  tickIcon = null

  $scope.stops = () ->
    event for event in $scope.data when event.event == 'PAUSE' || event.event == 'STOP'

  $scope.switchEvent = (event) ->
    $scope.currentEvent = event

  $scope.currentEvent = $scope.stops()[0]

  $window.markerClicked = (index) ->
    $scope.$apply () ->
      $scope.currentEvent = $scope.data[index]

  $scope.addMarker = (lat, lon) ->
    event =
      event: 'PAUSE'
      lat: lat
      lon: lon
      bearing: 180

    renderEvent(event)
    map.fitBounds(bounds)

  $scope.intervals = () ->
    intervals = []

    lastEvent = null
    for event in $scope.data
      continue unless event.event == 'START' || event.event == 'RESUME' || event.event == 'PAUSE' || event.event == 'STOP'

      if lastEvent?
        time = new Date(event.timestamp) - new Date(lastEvent.timestamp)

        type =
          if event.event == 'RESUME'
            'PAUSING'
          else
            'RIDING'

        intervals.push
          time: time
          type: type
          start: lastEvent
          stop: event

      lastEvent = event

    intervals

  $window.renderMap = () ->
    tickIcon = {
      url: 'http://www.clker.com/cliparts/7/1/a/c/11949857491086788994stock-circle.svg',
      scaledSize: new google.maps.Size(16, 16)
    }

    bounds = new google.maps.LatLngBounds()
    mapProperties =
      zoom: 8,
      mapTypeId: google.maps.MapTypeId.ROADMAP

    map = new google.maps.Map(document.getElementById("googleMap"), mapProperties);

    for event in $scope.data
      renderEvent(event)

    map.fitBounds(bounds);

  renderEvent = (event) ->
    return unless event.event == 'START' || event.event == 'STOP' || event.event == 'PAUSE' || event.event == 'TICK'

    icon = if event.event == 'TICK' then tickIcon else ''

    coords = new google.maps.LatLng(event.lat, event.lon)
    marker = new google.maps.Marker
      position: coords,
      map: map,
      icon: icon

    if event.event == 'PAUSE'
      google.maps.event.addListener marker, 'click', (marker) ->
        markerClicked(index)

    bounds.extend marker.position
]