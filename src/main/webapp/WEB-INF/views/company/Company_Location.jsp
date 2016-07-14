<!-- 
/*
 *  Description : 회사 소개 하단 회사 위치 map
 *  Created : 2016-06-26
 *  Author : 김준혁
 *  
 *  Revisions :
 */
 -->

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<script type="text/javascript"
	src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBuydEoBs8fFlyL6tDOb8sUNVu4hV82y9U&callback=initMap"></script>

<script type="text/javascript">
	// When the window has finished loading create our google map below
	google.maps.event.addDomListener(window, 'load', init);

	function init() {
		// Basic options for a simple Google Map
		// For more options see: https://developers.google.com/maps/documentation/javascript/reference#MapOptions
		var mapOptions = {
			// How zoomed in you want the map to start at (always required)
			zoom : 11,

			// The latitude and longitude to center the map (always required)
			center : new google.maps.LatLng(40.6700, -73.9400), // New York

			// How you would like to style the map. 
			// This is where you would paste any style found on Snazzy Maps.
			styles : [ {
				"featureType" : "all",
				"elementType" : "labels.text.fill",
				"stylers" : [ {
					"color" : "#ffffff"
				} ]
			}, {
				"featureType" : "all",
				"elementType" : "labels.text.stroke",
				"stylers" : [ {
					"color" : "#000000"
				}, {
					"lightness" : 13
				} ]
			}, {
				"featureType" : "administrative",
				"elementType" : "geometry.fill",
				"stylers" : [ {
					"color" : "#000000"
				} ]
			}, {
				"featureType" : "administrative",
				"elementType" : "geometry.stroke",
				"stylers" : [ {
					"color" : "#144b53"
				}, {
					"lightness" : 14
				}, {
					"weight" : 1.4
				} ]
			}, {
				"featureType" : "landscape",
				"elementType" : "all",
				"stylers" : [ {
					"color" : "#08304b"
				} ]
			}, {
				"featureType" : "poi",
				"elementType" : "geometry",
				"stylers" : [ {
					"color" : "#0c4152"
				}, {
					"lightness" : 5
				} ]
			}, {
				"featureType" : "road.highway",
				"elementType" : "geometry.fill",
				"stylers" : [ {
					"color" : "#000000"
				} ]
			}, {
				"featureType" : "road.highway",
				"elementType" : "geometry.stroke",
				"stylers" : [ {
					"color" : "#0b434f"
				}, {
					"lightness" : 25
				} ]
			}, {
				"featureType" : "road.arterial",
				"elementType" : "geometry.fill",
				"stylers" : [ {
					"color" : "#000000"
				} ]
			}, {
				"featureType" : "road.arterial",
				"elementType" : "geometry.stroke",
				"stylers" : [ {
					"color" : "#0b3d51"
				}, {
					"lightness" : 16
				} ]
			}, {
				"featureType" : "road.local",
				"elementType" : "geometry",
				"stylers" : [ {
					"color" : "#000000"
				} ]
			}, {
				"featureType" : "transit",
				"elementType" : "all",
				"stylers" : [ {
					"color" : "#146474"
				} ]
			}, {
				"featureType" : "water",
				"elementType" : "all",
				"stylers" : [ {
					"color" : "#021019"
				} ]
			} ]
		};

		// Get the HTML DOM element that will contain your map 
		// We are using a div with id="map" seen below in the <body>
		var mapElement = document.getElementById('map');

		// Create the Google Map using our element and options defined above
		var map = new google.maps.Map(mapElement, mapOptions);

		// Let's also add a marker while we're at it
		var marker = new google.maps.Marker({
			position : new google.maps.LatLng(40.6700, -73.9400),
			map : map,
			title : 'Snazzy!'
		});
	}
</script>

<style type="text/css">
/* Set a size for our map container, the Google Map will take up 100% of this container */
#map {
	width: 1170px;
	height: 300px;
}
</style>
<div id="CEO-Div" class="container div-fade"
	style="display: none;">
	<div class="row">
		<div id="map" style="margin-right: 0px !important;"></div>
	</div>
</div>



