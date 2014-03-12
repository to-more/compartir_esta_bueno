# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery -> 

		zoom = 11

		$("#main-bar").animate({opacity: 0.45},"slow")

		$("#main-bar").on("mouseover",() ->
			$("#main-bar").animate({opacity: 0.85},"slow")
		)

		$("#main-bar").on("mouseleave",() ->
			$("#main-bar").animate({opacity: 0.0},"slow")
		)

		map = new OpenLayers.Map("map")
		mapnik = new OpenLayers.Layer.OSM()
		fromProjection = new OpenLayers.Projection("EPSG:4326")
		toProjection = new OpenLayers.Projection("EPSG:900913")
		map.addLayer(mapnik)

		addMarker = (map,data) -> 
			markerslayer = new OpenLayers.Layer.Markers( "Markers" )
			map.addLayer(markerslayer)
			size = new OpenLayers.Size(30,35);
			offset = new OpenLayers.Pixel(-(size.w/2), -size.h);
			icon = new OpenLayers.Icon('http://www.clker.com/cliparts/W/x/V/N/a/o/orange-pin-md.png', size, offset)
			lonLat = new OpenLayers.LonLat(data.longitude, data.latitude).transform( fromProjection, toProjection)
			markerslayer.addMarker( new OpenLayers.Marker lonLat, icon)
			lonLat

		resp = $.getJSON "http://api.hostip.info/get_json.php", (data) ->
			console.log data.ip
			ip = data.ip.replace /[.]/g, '-'
			url = "/search_by_ip/" + ip
			console.log ip
			request = $.ajax
				type: "GET"
				url: url
				dataType: "json"
				success: (data) ->
					console.log data.latitude
					console.log data.longitude
					lonLat = addMarker(map,data)
					map.setCenter(lonLat, zoom )		

		contextMenu = $("#contextMenu")
		
		subMenu = (e) -> 
			contextMenu.css 
				left: e.pageX 
				top: e.pageY 
				display: "block"
				position: "absolute"
			false

		$("body").on "contextmenu",  "#map", subMenu

		map.events.register "click", map.events.object, () -> contextMenu.hide()
		
		$("#lock_up_location").click () -> 
			$("#contextMenu").hide
			address = $("#busca_router").val()
			url = "search_by_address/" + address
			request = $.ajax
				type: "GET"
				url: url
				dataType: "json"
				success: (data) -> 
					console.log data.latitude
					console.log data.longitude
					lonLat = addMarker(map,data)
					zoom = 15
					map.setCenter(lonLat, zoom )


		enter_pressed = (event) -> 
			event = event or window.event
			if event
				key = event.keyCode or event.which
				if key is 13
					event.preventDefault()
					$("#lock_up_location").trigger "click"

		$("#busca_router").keypress enter_pressed
		
		map.addControl(new OpenLayers.Control.LayerSwitcher())