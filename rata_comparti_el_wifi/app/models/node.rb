class Node
  
  include Mongoid::Document
  field :router, type: Router
  field :coordinate, type: Coordinate
  field :link, type: Link

	def initialize coordinate,router
		@coordinate = coordinate
		@router = router
		@link = Link.new coordinate
	end

	def link_to coordinate
		@link.link_to coordinate
	end

	def linked?
		@link.linked?		
	end

end
