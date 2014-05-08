class Node
  	
	include Mongoid::Document

	embeds_many :routers, class_name: "Router"
	
	embeds_one :location, class_name: "Location"

	embeds_one :link, class_name: "Link"

	class << self
	    def find_by_coordinate 
	    	coordinate = yield
		    if coordinate
		      longitude = coordinate['longitude'].to_f
		      latitude = coordinate['latitude'].to_f
		      node = Node.where( 'location.longitude' => longitude, 'location.latitude' =>  latitude).first
		    end	      
	    end

	    def build

	    	node = yield

	    	location = node[:location]
    		router = node[:router]

    		@node = Node.where( 'location.address' => location[:address]).first

		    unless @node
		    	@node = Node.new
		    end

		    @node.build_location( :address => location[:address])

		    ruter = Router.new( :ip => router[:ip], 
		      :mac =>  router[:mac], 
		      :essid => router[:essid], 
		      :password => router[:password],
		      :channel => router[:channel],
		      :comment => router[:comment]
		    )

		    @node.routers.push ruter
		    
		    return @node
	    end
  	end  	

	def link_to coordinate
		@link.link_to location
	end

	def linked?
		@link.linked?		
	end

end
