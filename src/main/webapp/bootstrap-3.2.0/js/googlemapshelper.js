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

var markers = new Array(3);
for (var i = 0; i < markers.length; i++) {
  markers[i] = new Array(10);
}

var prevBouncingTabIndex = 0;
var prevBouncingIndex = 0;

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


function selectOnePlace(tabIndex, index) {
	document.getElementById(tabs[prevTabIndex]+prevSelectPlace).className = "";
    document.getElementById(tabs[tabIndex]+index).className = "selectedPlace";
    
    prevSelectPlace = index;
    prevTabIndex = tabIndex;
}

function goToAnchor(tabIndex, index){
	var url = location.href;
    location.href = "#"+tabs[tabIndex]+index;
    history.replaceState(null,null,url);
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
	  selectOnePlace(tabIndex, index);
	  goToAnchor(tabIndex, index);
    });

	// Show marker on map
	marker.setMap(map);
	
	markers[tabIndex][index] = marker;
}

function bounce(tabIndex, index) {
	var marker = markers[tabIndex][index];
	var prevMarker = markers[prevBouncingTabIndex][prevBouncingIndex];
	
	prevMarker.setAnimation(null);
	
	// Is the marker already animating?
	if (marker.getAnimation()) {
		marker.setAnimation(null);
	} else {
		// Make it bounce!
		marker.setAnimation(google.maps.Animation.BOUNCE);
	}
	
	selectOnePlace(tabIndex, index);
	
	prevBouncingIndex = index;
	prevBouncingTabIndex = tabIndex;
}