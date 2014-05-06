# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

class window.MapEventManager
		
		back_to_root: ->
			$("#back_to_root").click (e)-> 
				$("#bodyContent").hide "slow", () -> 
					$("#map").show "slow"
					e.preventDefault()
				false

		new_node: ->
			$("#new_node").click (e)-> 
				e.preventDefault()
				locale = window.location.pathname.replace /[/]/g, ""

				locale = "/#{locale}" unless locale is "" 

				$("#contextMenu").hide()
				$("#map").hide "slow", ()->
					url = "#{locale}/nodes/new#main_container"
					$("#bodyContent").show "slow", ()->
						$("#bodyContent").load url

		enter_pressed_on_busca_router: ->
			enter_pressed = (event) ->
				event = event or window.event
				if event
					key = event.keyCode or event.which
					if key is 13
						event.preventDefault()
						$("#lock_up_location").trigger "click"
			$("#busca_router").keypress enter_pressed		

		keyup_on_busca_router: ->
			$("#busca_router").keyup((e)->
				if e.keyCode is 9 
					$("#main-bar").animate({opacity: 0.45},"slow")
			)

		keydown_on_busca_router: ->
			$("#busca_router").keydown((e)->
				if e.keyCode is 9 
					$("#main-bar").animate({opacity: 0.0},"slow")
			)

		onload_main_bar: -> 
			$("#main-bar").animate({opacity: 0.45},"slow")

		on_mouseover_main_bar: ->
			$("#main-bar").on("mouseover",() ->
				$("#main-bar").stop().animate({opacity: 0.85},"slow")
			)

		on_mouseleave_main_bar: -> 
			$("#main-bar").on("mouseleave",(e) ->
				focused = $(document.activeElement)
				idFocused = focused.attr("id")
				$("#main-bar").stop().animate({opacity: 0.0},"slow") if idFocused isnt "busca_router"
			)