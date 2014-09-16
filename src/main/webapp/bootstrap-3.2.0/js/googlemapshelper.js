/**
 * 
 */

//Global variables
var map;
var prevSelectPlace = 0;
var prevTabIndex = 0;

var tabs = ['resto_', 'attraction_', 'pub_'];
var icons = ['http://maps.google.com/mapfiles/ms/icons/red-dot.png',
             'http://maps.google.com/mapfiles/ms/icons/green-dot.png',
             'http://maps.google.com/mapfiles/ms/icons/yellow-dot.png'];

function initializeMapPlaces(positions, places, zoomVal, tabIndex) {
	var sumLat = 0;
	var sumLong = 0;
	for (var i = 0; i < positions.length; i++) {
		sumLat+=positions[i].lat();
		sumLong+=positions[i].lng();
	}
	sumLat/=positions.length;
	sumLong/=positions.length;
	var centerPos = new google.maps.LatLng(sumLat, sumLong);
	
	// Init the map
	var myOptions = {
			zoom: zoomVal,
			center: centerPos,
			mapTypeId: google.maps.MapTypeId.ROADMAP
	};

	map = new google.maps.Map(document.getElementById('map_places'), myOptions);
	
	// delegate it with a parameter containing all the positions
	for (var i = 0; i < positions.length; i++) {
		addLocationAndLink(positions[i], places[i], i, tabIndex);
	}
}

function addLocationAndLink(pos, link, index, tabIndex){
	// Get coordinates
	var options = {
			position: pos,
			title: link,
			icon: icons[tabIndex]
	};
	var marker = new google.maps.Marker(options);
	
	google.maps.event.addListener(marker, 'click', function() {
	  document.getElementById(tabs[prevTabIndex]+prevSelectPlace).className = "";
      document.getElementById(tabs[tabIndex]+index).className = "selectedPlace";
      
      var url = location.href;
      location.href = "#"+tabs[tabIndex]+index;
      history.replaceState(null,null,url);
      
      prevSelectPlace = index;
      prevTabIndex = tabIndex;
    });

	// Show marker on map
	marker.setMap(map);
}

function addLocation(pos){
	// Get coordinates
	var options = {
			position: pos
	};
	var marker = new google.maps.Marker(options);

	// Show marker on map
	marker.setMap(map);
	bounce(marker);
}

function bounce(marker) {
	// Is the marker already animating?
	if (marker.getAnimation()) {
		marker.setAnimation(null);
	} else {
		// Make it bounce!
		marker.setAnimation(google.maps.Animation.BOUNCE);
	}
}