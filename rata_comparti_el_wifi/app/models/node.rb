class Node
  	
	include Mongoid::Document

	embeds_one :router, class_name: "Router"
	embeds_one :location, class_name: "Location"
	embeds_one :link, class_name: "Link"

	after_initialize :linked_relations

	def linked_relations
		self.location = Location.new
		self.link = Link.new
		self.router = Router.new
	end

	def link_to coordinate
		@link.link_to location
	end

	def linked?
		@link.linked?		
	end

end
