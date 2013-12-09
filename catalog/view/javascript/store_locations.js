var infowindow;
var map;
var gmarkers = [];
var geocoder;

$(document).ready(function() {
    var script = document.createElement("script");
    script.type = "text/javascript";
    script.async = 1;
    script.src = "//maps.googleapis.com/maps/api/js?sensor=false&callback=map_init";
    document.body.appendChild(script);
});

// Create a marker for each XML entry
function addMarker(html, markerCoords) {

    // Place the new marker
    var marker = new google.maps.Marker({
        animation: google.maps.Animation.DROP,
        map: map,
        position: markerCoords
    }); // end place the new marker

    // Add event listener. On marker click, close all open infoWindows open current infoWindow.
    google.maps.event.addListener(marker, "click", function() {
        if (infowindow) infowindow.close();
        infowindow = new google.maps.InfoWindow({
            content: html
        });
        infowindow.open(map, marker);
    }); // end add event listener
    
    gmarkers.push(marker);

    // Display marker
    return marker;

} // end addMarker();

function GAclick(i) {
    google.maps.event.trigger(gmarkers[i], "click");
    map.setZoom(14);
}

function map_init() {
    
    geocoder = new google.maps.Geocoder();
        
    //var latlng = new google.maps.LatLng(55.378051,-3.435973);
    var latlng = new google.maps.LatLng(34.307144,-37.96875);
    var mapOptions = {
        zoom: 2,
        center: latlng,
        mapTypeId: google.maps.MapTypeId.ROADMAP
    }
    map = new google.maps.Map(document.getElementById('map'), mapOptions);

    if (typeof map_address != 'undefined') {
        findAddress(map_address);
    } else if (typeof map_lat !== 'undefined' && typeof map_lon !== 'undefined') {
        var latlng = new google.maps.LatLng(map_lat,map_lon);
        map.setCenter(latlng);
        map.setZoom(10);
    }
       
    place_pins_on_map();
}

var got_pins = false;
function place_pins_on_map ()
{
    if (!got_pins && typeof get_pins != 'undefined' && get_pins)
    {
        if (typeof getMarkers != 'undefined')
        {
            got_pins = true;
            $.getJSON(getMarkers, function(data) {
                if (data.length) {
                    var LatLngList = new Array();
                    var bounds = new google.maps.LatLngBounds ();
                    for ($i = 0; $i < data.length; $i++)
                    {
                        var markerCoords = new google.maps.LatLng(
                            parseFloat(data[$i].lat),
                            parseFloat(data[$i].lon)
                            );

                        var html = "<div class='info-blob'>" + data[$i].html + "</div>";  

                        LatLngList[LatLngList.length] = markerCoords;

                        $('#store' + data[$i].ID).append('<p><a href="' + document.URL + '#map" onclick="GAclick(' + gmarkers.length + ');">' + text_view_on_map + '</a></p>');
                        var marker = addMarker(html, markerCoords);
                    }
                    for (var i = 0, LtLgLen = LatLngList.length; i < LtLgLen; i++) {
                        //  And increase the bounds to take this point
                        bounds.extend (LatLngList[i]);
                      }
                    map.fitBounds (bounds);
                } else {
                    map.setZoom(4);
                }
            });
        } 
    }
}

function findAddress(address) {
    geocoder.geocode( {
        'address': address
    }, function(results, status) {
        if (status == google.maps.GeocoderStatus.OK) {
            map.setCenter(results[0].geometry.location);
            map.setZoom(4);
        } else {
            alert('Geocode was not successful for the following reason: ' + status);
        }
    });
}

