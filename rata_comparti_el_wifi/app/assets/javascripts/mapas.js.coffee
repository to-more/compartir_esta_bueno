# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
jQuery -> 

		zoom = 12
		map = new OpenLayers.Map("map")
		mapnik = new OpenLayers.Layer.OSM()
		fromProjection = new OpenLayers.Projection("EPSG:4326")
		toProjection = new OpenLayers.Projection("EPSG:900913")
		position = new OpenLayers.LonLat(-58.381593100000030000,-34.603723200000000000 ).transform( fromProjection, toProjection)
		map.addLayer(mapnik);map.setCenter(position, zoom )

		

		listener = (e) ->
			position = this.events.getMousePosition(e)
			size = new OpenLayers.Size(30,35);
			offset = new OpenLayers.Pixel(-(size.w/2), -size.h);
			icon = new OpenLayers.Icon('http://www.clker.com/cliparts/W/x/V/N/a/o/orange-pin-md.png', size, offset)
			lonlat = map.getLonLatFromPixel(position)
			lonlatTransf = lonlat.transform(map.getProjectionObject(), fromProjection)
			lonlat = lonlatTransf.transform(fromProjection, map.getProjectionObject())
			markerslayer = new OpenLayers.Layer.Markers( "Markers" )
			markerslayer.addMarker(new OpenLayers.Marker(lonlat, icon))
			map.addLayer(markerslayer)

		map.events.register("click", map, listener)
		map.addControl(new OpenLayers.Control.LayerSwitcher())