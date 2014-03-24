# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery -> 

		zoom = 11


		$("#back_to_root").click (e)-> 
			$("#bodyContent").hide "slow", () -> 
				$("#map").show "slow"
				e.preventDefault()
			false

		$("#new_node").click (e)-> 
			e.preventDefault()
			$("#contextMenu").hide()
			$("#map").hide "slow", loadRelated

		loadRelated = () ->
			url = "/nodes/new"
			$("#bodyContent").show "slow", ()->
				$("#bodyContent").load url
			

		$("#busca_router").keyup((e)->
			if e.keyCode is 9 
				$("#main-bar").animate({opacity: 0.45},"slow")
		)

		$("#busca_router").keydown((e)->
			if e.keyCode is 9 
				$("#main-bar").animate({opacity: 0.0},"slow")
		)

		$("#main-bar").animate({opacity: 0.45},"slow")

		$("#main-bar").on("mouseover",() ->
			$("#main-bar").stop().animate({opacity: 0.85},"slow")
		)

		$("#main-bar").on("mouseleave",(e) ->
			focused = $(document.activeElement)
			idFocused = focused.attr("id")
			$("#main-bar").stop().animate({opacity: 0.0},"slow") if idFocused isnt "busca_router"
		)

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
						long = node.location.coordinates[0]
						lat  = node.location.coordinates[1] 
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


		enter_pressed = (event) -> 
			event = event or window.event
			if event
				key = event.keyCode or event.which
				if key is 13
					event.preventDefault()
					$("#lock_up_location").trigger "click"

		$("#busca_router").keypress enter_pressed