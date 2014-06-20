# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

class window.Map
		
	getLonLat: (longitude, latitude) ->
		lonLat = new OpenLayers.LonLat(longitude, latitude).transform( @fromProjection, @toProjection)

	addMarker: (longitude, latitude) ->
		markerslayer = new OpenLayers.Layer.Markers( "Markers" )
		
		size = new OpenLayers.Size(50,55);
		offset = new OpenLayers.Pixel(-(size.w/2), -size.h);

		icon = new OpenLayers.Icon("#{window.location.href}get_image", size, offset)

		lonLat = this.getLonLat(longitude, latitude)
		marker = new OpenLayers.Marker lonLat, icon
		
		node = new Object

		coordinate = { "longitude":longitude, "latitude": latitude}
		url = "/search_by_coordinate"
		$.ajax
			data: {coordinate: coordinate}
			type: "GET"
			url: url
			dataType: "json"		
			success: (data) -> 
				node = data

		listener = () -> 
			if node
				empty = ""
				address = if node.location then node.location.address else empty
				if node.routers
					routers = node.routers

					ul = $("<ul/>")
					ul.attr "id", address
					
					$.each routers, (i) ->
						exist = ul.children "#"+i
						if exist.length is 0
							li = $("<li/>")
							li.attr "id", i
							li.appendTo(ul)

							essid = $("<div/>")
							essid.text( "Essid:" + routers[i].essid)

							pass = $("<div/>")
							pass.text "Password:" + routers[i].password

							channel = $("<div/>")

							channel_text = if routers[i].channel then routers[i].channel else empty

							channel.text "channel:" + channel_text

							comment = $("<div/>")
							comment.text "comment:" + routers[i].comment

							li.html essid.append pass.append channel.append comment

				$("#address").html "Address: " + address

				$("#router").text "Routers: "
				$("#router").append ul

				$("#modal").modal "show"

		marker.events.register "click", marker.events.object, listener

		markerslayer.addMarker( marker )

		@map.addLayer(markerslayer)

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