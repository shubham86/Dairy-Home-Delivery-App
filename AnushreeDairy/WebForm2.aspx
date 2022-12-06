<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WebForm2.aspx.cs" Inherits="AnushreeDairy.WebForm2" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title></title>
    
    
</head>
<body>
    <form id="form1" runat="server">
            <div style="margin-top:20px">
            <input id="lat" readonly="readonly"/>
            <input id="lng" readonly="readonly"/>
        </div>

        <div id="map"></div>
        <style>
            #map {
                height: 400px;
            }
        </style>
        <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBk25E4mNfVIEt3tNl3K1HwNZVruVoFBlA"></script>
        <script>
            var directionsDisplay;
            var directionsService = new google.maps.DirectionsService();
            var map;
            var endMarker;

            function initialize() {
                directionsDisplay = new google.maps.DirectionsRenderer();
                var paris = new google.maps.LatLng(18.52073289770824, 73.85648647119137);
                var mapOptions = {
                    zoom: 12,
                    center: paris
                }
                map = new google.maps.Map(document.getElementById("map"), mapOptions);
                directionsDisplay.setMap(map);

                // if any previous marker exists, let's first remove it from the map
                if (endMarker) {
                    endMarker.setMap(null);
                }
                // create the marker
                endMarker = new google.maps.Marker({
                    position: paris,
                    map: map,
                    draggable: true,
                });
                copyMarkerpositionToInput();
                // add an event "onDrag"
                google.maps.event.addListener(endMarker, 'dragend', function () {
                    copyMarkerpositionToInput();
                });
            }

            function copyMarkerpositionToInput() {
                // get the position of the marker, and set it as the value of input
                document.getElementById("lat").value = endMarker.getPosition().lat()
                document.getElementById("lng").value = endMarker.getPosition().lng();
            }

            function calcRoute() {
                var start = document.getElementById("start").value;
                var end = document.getElementById("end").value;
                var request = {
                    origin: start,
                    destination: end,
                    travelMode: google.maps.TravelMode.DRIVING
                };
                directionsService.route(request, function (result, status) {
                    if (status == google.maps.DirectionsStatus.OK) {
                        directionsDisplay.setDirections(result);
                    }
                });
            }
            google.maps.event.addDomListener(window, 'load', initialize);
        </script>
    </form>
</body>
</html>
