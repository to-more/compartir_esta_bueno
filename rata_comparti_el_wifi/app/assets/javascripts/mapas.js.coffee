# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery -> 

		zoom = 11

		mapEventManager = new MapEventManager()

		mapEventManager.back_to_root()

		mapEventManager.new_node()

		mapEventManager.keyup_on_busca_router()

		mapEventManager.keydown_on_busca_router()

		mapEventManager.enter_pressed_on_busca_router()

		mapEventManager.onload_main_bar()

		mapEventManager.on_mouseover_main_bar()

		mapEventManager.on_mouseleave_main_bar()

		map = new Map("map")

		request_index = $.ajax
			type: "GET"
			url: "/nodes"
			dataType: "json"
			success: (data) ->
				console.log "Size: " + data.length
				for node in data
					long = 0
					lat = 0
					if node.location 
						long = node.location.longitude
						lat  = node.location.latitude
						console.log "Address: " + node.location.address
						console.log "[" + lat + "," + long + "]"
						map.addMarker(long, lat)

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
					map.addMarker(data.longitude, data.latitude)
					map.center(data.longitude, data.latitude, zoom )

		contextMenu = $("#contextMenu")
		
		subMenu = (e) -> 
			contextMenu.css 
				left: e.pageX 
				top: e.pageY 
				display: "block"
				position: "absolute"
			false

		$("body").on "contextmenu",  "#map", subMenu

		map.take_event_with_listener "click", () -> contextMenu.hide()
		
		$("#lock_up_location").click () -> 
			$("#contextMenu").hide()
			$("#bodyContent").hide "slow", () -> 
				$("#map").show "slow"
			address = $("#busca_router").val()
			url = "search_by_address/" + address
			request = $.ajax
				type: "GET"
				url: url
				dataType: "json"
				success: (data) -> 
					console.log data.latitude
					console.log data.longitude
					map.addMarker(data.longitude, data.latitude)
					zoom = 15
					map.center(data.longitude, data.latitude, zoom )