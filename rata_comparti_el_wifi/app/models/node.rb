class Node
  	
	include Mongoid::Document

	embeds_one :router, class_name: "Router"
	embeds_one :location, class_name: "Location"
	embeds_one :link, class_name: "Link"

	class << self
	    def find_by_coordinate 
	    	coordinate = yield
		    if coordinate
		      longitude = coordinate['longitude'].to_f
		      latitude = coordinate['latitude'].to_f
		      node = Node.where( 'location.longitude' => longitude, 'location.latitude' =>  latitude)
		    end	      
	    end
  	end  	

	def link_to coordinate
		@link.link_to location
	end

	def linked?
		@link.linked?		
	end

end
