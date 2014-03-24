# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

class window.Map
		
	getLonLat: (longitude, latitude) ->
		lonLat = new OpenLayers.LonLat(longitude, latitude).transform( @fromProjection, @toProjection)

	addMarker: (longitude, latitude) ->
		markerslayer = new OpenLayers.Layer.Markers( "Markers" )
		@map.addLayer(markerslayer)
		size = new OpenLayers.Size(50,55);
		offset = new OpenLayers.Pixel(-(size.w/2), -size.h);
		icon = new OpenLayers.Icon('http://www.clker.com/cliparts/W/x/V/N/a/o/orange-pin-md.png', size, offset)
		lonLat = this.getLonLat(longitude, latitude)
		markerslayer.addMarker( new OpenLayers.Marker lonLat, icon)

	center: (longitude, latitude, zoom) -> 
		lonLat = this.getLonLat(longitude, latitude)
		@map.setCenter(lonLat, zoom )

	take_event_with_listener: (event,listener) -> 
		@map.events.register event, @map.events.object, listener

	constructor: (tag) ->
		@map = new OpenLayers.Map(tag)
		@fromProjection = new OpenLayers.Projection("EPSG:4326")
		@toProjection = new OpenLayers.Projection("EPSG:900913")
		mapnik = new OpenLayers.Layer.OSM()
		@map.addLayer(mapnik)
		@map.addControl(new OpenLayers.Control.LayerSwitcher())