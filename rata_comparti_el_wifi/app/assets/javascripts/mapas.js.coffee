# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
jQuery -> 
		zoom = 11.5
		map = new OpenLayers.Map("map")
		mapnik = new OpenLayers.Layer.OSM()
		fromProjection = new OpenLayers.Projection("EPSG:4326")
		toProjection = new OpenLayers.Projection("EPSG:900913")
		position = new OpenLayers.LonLat(-58.381593100000030000,-34.619000000000 ).transform( fromProjection, toProjection)
		map.addLayer(mapnik);map.setCenter(position, zoom )
		
		contextMenu = $("#contextMenu")
		
		subMenu = (e) -> 
			contextMenu.css 
				left: e.pageX 
				top: e.pageY 
				display: "block"
				position: "absolute"
			false
		
		$("body").on "contextmenu",  "#map", subMenu

		$("#lock_up_location").click () -> 
			request = $.ajax
				type: "GET"
				url: "maps"
			request.done console.log "Send ajax request"


		enter_pressed = (event) -> 
			event = event or window.event
			if event
				key = event.keyCode or event.which
				if key is 13
					event.preventDefault()
					$("#lock_up_location").trigger "click"

		$("#busca_router").keypress enter_pressed

		listener = (e) ->
			contextMenu.hide()
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
