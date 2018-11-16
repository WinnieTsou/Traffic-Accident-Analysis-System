<div id="map" style="width: 100%; height: 400px; background-color: #dddddd;">
	<p>Google Map is not loaded. :((</p>
</div>

<script>
var map;
			
function initMap() {
	var MN = {lat: 46.530, lng: -94.6859};
	var map = new google.maps.Map(document.getElementById('map'), {
		zoom: 6,
		center: MN,
		// zoomControl: false,
		mapTypeControl: false,
		// scaleControl: false,
		streetViewControl: false,
		rotateControl: false,
		fullscreenControl: false
	});
	var MNBoundaryPolygon = new google.maps.Polygon({
		paths: MNBoundary,
		strokeColor: '#FF0000',
		strokeOpacity: 0.8,
		strokeWeight: 2,
		fillColor: '#FF0000',
		fillOpacity: 0.1
	});
	MNBoundaryPolygon.setMap(map);

// Data Points

	// var marker = new google.maps.Marker({
	// 	position: MN,
	// 	map: map,
	// 	title: 'MN (Ayers Rock)'
	// });

	var infowindow = new google.maps.InfoWindow();

	// marker.addListener('click', function() {
	// 	infowindow.open(map, marker);
	// });

	$.getJSON('data?page=all', function(json) {

		$.each(json, function (key, data) {

			var latLng = new google.maps.LatLng(data.latitude, data.longitude);
			var marker = new google.maps.Marker({
				position: latLng,
				map: map,
				title: data.casenum
			});

			var details =
				'<div id="content">'+
				'<div id="siteNotice"></div>'+
				'<h1 id="firstHeading" class="firstHeading">' + 'Case ID: ' + data.casenum + '</h1>'+
				'<div id="bodyContent">'+
				'<p>' + 'Happend Time: ' + data.accident_date.substring(0, data.accident_date.length - 5) + '</p>'+
				'<p></p>'+
				'</div>'+
				'</div>';

			bindInfoWindow(marker, map, infowindow, details);

		});

		function bindInfoWindow(marker, map, infowindow, strDescription) {
			google.maps.event.addListener(marker, 'click', function () {
				infowindow.setContent(strDescription);
				infowindow.open(map, marker);
			});
		}
	});
}
</script>
<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyAATfq2_60fgdqXMK6NP9FTKFLOltGwu3E&callback=initMap" async defer></script>

<script>
var MNBoundary = [
	{lng: -97.225,	lat: 48.975},
	{lng: -95.15,	lat: 49},
	{lng: -95.15,	lat: 49.375},
	{lng: -94.95,	lat: 49.375},
	{lng: -94.825,	lat: 49.325},
	{lng: -94.675,	lat: 48.875},
	{lng: -94.7,	lat: 48.775},
	{lng: -94.55,	lat: 48.7},
	{lng: -94.25,	lat: 48.7},
	{lng: -94.25,	lat: 48.65},
	{lng: -93.825,	lat: 48.625},
	{lng: -93.825,	lat: 48.525},
	{lng: -93.525,	lat: 48.525},
	{lng: -93.45,	lat: 48.55},
	{lng: -93.475,	lat: 48.6},
	{lng: -93.25,	lat: 48.65},
	{lng: -92.95,	lat: 48.625},
	{lng: -92.625,	lat: 48.55},
	{lng: -92.625,	lat: 48.5},
	{lng: -92.725,	lat: 48.475},
	{lng: -92.65,	lat: 48.425},
	{lng: -92.45,	lat: 48.425},
	{lng: -92.475,	lat: 48.35},
	{lng: -92.375,	lat: 48.225},
	{lng: -92.275,	lat: 48.25},
	{lng: -92.3,	lat: 48.35},
	{lng: -92.15,	lat: 48.375},
	{lng: -92,		lat: 48.325},
	{lng: -92.025,	lat: 48.3},
	{lng: -91.95,	lat: 48.225},
	{lng: -91.9,	lat: 48.25},
	{lng: -91.875,	lat: 48.2},
	{lng: -91.7,	lat: 48.2},
	{lng: -91.725,	lat: 48.175},
	{lng: -91.675,	lat: 48.125},
	{lng: -91.7,	lat: 48.1},
	{lng: -91.575,	lat: 48.1},
	{lng: -91.575,	lat: 48.05},
	{lng: -91.25,	lat: 48.075},
	{lng: -91.125,	lat: 48.175},
	{lng: -90.85,	lat: 48.25},
	{lng: -90.775,	lat: 48.1},
	{lng: -90.025,	lat: 48.1},
	{lng: -90,		lat: 48.025},
	{lng: -89.925,	lat: 48.025},
	{lng: -89.875,	lat: 47.975},
	{lng: -89.825,	lat: 48.025},
	{lng: -89.725,	lat: 48},
	{lng: -89.475,	lat: 48.025},
	{lng: -89.95,	lat: 47.3},
	{lng: -90.675,	lat: 47.3},
	{lng: -92,		lat: 46.7},
	{lng: -92.15,	lat: 46.75},
	{lng: -92.2,	lat: 46.725},
	{lng: -92.2,	lat: 46.65},
	{lng: -92.3,	lat: 46.675},
	{lng: -92.3,	lat: 46.075},
	{lng: -92.35,	lat: 46.025},
	{lng: -92.45,	lat: 46.025},
	{lng: -92.475,	lat: 45.975},
	{lng: -92.725,	lat: 45.9},
	{lng: -92.75,	lat: 45.8},
	{lng: -92.825,	lat: 45.725},
	{lng: -92.875,	lat: 45.725},
	{lng: -92.875,	lat: 45.575},
	{lng: -92.725,	lat: 45.55},
	{lng: -92.725,	lat: 45.5},
	{lng: -92.65,	lat: 45.45},
	{lng: -92.7,	lat: 45.325},
	{lng: -92.775,	lat: 45.3},
	{lng: -92.75,	lat: 45.1},
	{lng: -92.8,	lat: 45.05},
	{lng: -92.75,	lat: 44.9},
	{lng: -92.8,	lat: 44.75},
	{lng: -92.625,	lat: 44.65},
	{lng: -92.625,	lat: 44.6},
	{lng: -92.325,	lat: 44.55},
	{lng: -92.3,	lat: 44.475},
	{lng: -91.925,	lat: 44.35},
	{lng: -91.925,	lat: 44.275},
	{lng: -91.85,	lat: 44.175},
	{lng: -91.7,	lat: 44.125},
	{lng: -91.55,	lat: 44.03},
	{lng: -91.425,	lat: 44},
	{lng: -91.25,	lat: 43.8},
	{lng: -91.275,	lat: 43.6},
	{lng: -91.225,	lat: 43.575},
	{lng: -91.225,	lat: 43.5},
	{lng: -96.45,	lat: 43.5},
	{lng: -96.45,	lat: 45.325},
	{lng: -96.575,	lat: 45.4},
	{lng: -96.675,	lat: 45.4},
	{lng: -96.75,	lat: 45.475},
	{lng: -96.75,	lat: 45.525},
	{lng: -96.85,	lat: 45.6},
	{lng: -96.85,	lat: 45.65},
	{lng: -96.675,	lat: 45.725},
	{lng: -96.575,	lat: 45.825},
	{lng: -96.55,	lat: 46.125},
	{lng: -96.6,	lat: 46.175},
	{lng: -96.6,	lat: 46.325},
	{lng: -96.75,	lat: 46.475},
	{lng: -96.75,	lat: 46.6},
	{lng: -96.8,	lat: 46.625},
	{lng: -96.775,	lat: 46.925},
	{lng: -96.825,	lat: 46.975},
	{lng: -96.85,	lat: 47.6},
	{lng: -96.95,	lat: 47.75},
	{lng: -96.925,	lat: 47.775},
	{lng: -96.975,	lat: 47.775},
	{lng: -96.95,	lat: 47.8},
	{lng: -97.025,	lat: 47.875},
	{lng: -97.025,	lat: 47.95},
	{lng: -97.15,	lat: 48.15},
	{lng: -97.125,	lat: 48.525},
	{lng: -97.175,	lat: 48.575},
	{lng: -97.15,	lat: 48.625},
	{lng: -97.1,	lat: 48.625},
	{lng: -97.1,	lat: 48.7},
	{lng: -97.15,	lat: 48.725},
	{lng: -97.225,	lat: 48.975}
];
</script>