app = angular.module('takearide', [])

app.controller 'HomeController', ['$scope', '$window', ($scope, $window) ->
  $scope.data = $window.data

  $scope.stops = () ->
    event for event in $scope.data when event.event == 'PAUSE'

  $scope.switchEvent = (event) ->
    $scope.currentEvent = event

  $scope.currentEvent = $scope.stops()[0]

  $window.markerClicked = (index) ->
    $scope.$apply () ->
      $scope.currentEvent = $scope.data[index]
]