class Node
  
  include Mongoid::Document
  field :router, type: Router
  field :location, type: Location
  field :link, type: Link

	def link_to coordinate
		@link.link_to location
	end

	def linked?
		@link.linked?		
	end

end
