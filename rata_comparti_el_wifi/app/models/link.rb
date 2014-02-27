class Link
  include Mongoid::Document
  field :coordinates, type: Coordinate
  
	def initialize coordinate
		@coordinates = [coordinate]
	end


	def link_to coordinate
		if @coordinates  then
			@coordinates.push(coordinate)
		end
	end

	def one_node?
		@coordinates.length == 1
	end

	def linked?
		@coordinates.length == 2
	end

end