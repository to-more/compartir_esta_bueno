class Map
	#require 'mongo'
	include Mongoid::Document
	include Geocoder::Model::Mongoid
	field :address, type: String
	field :latitude, type: Float
	field :longitude, type: Float
	field :coordinates, :type => Array

	#index [[ :coordinates, Mongo::GEO2D ]]

	geocoded_by :address 

 	before_save :set_location

	after_validation :geocode 

	def set_location
		debugger

		if self.address then
			search = Geocoder.search(self.address)
		end
		result = nil
		result =  search.first
		if result then
			self.coordinates = result.coordinates if self.address_changed? || self.new_record?
			lat, lng = result.coordinates
			self.latitude = lat
			self.longitude = lng
		end
	end

end
