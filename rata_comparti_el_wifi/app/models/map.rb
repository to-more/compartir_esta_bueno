class Map
	#require 'mongo'
	include Mongoid::Document
	include Geocoder::Model::Mongoid
	field :ip, type: String
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

	def search_by_ip

		self.ip = self.ip.gsub('-','.')

		location = GeoIP.new("#{Rails.root}/lib/GeoLiteCity.dat").city(ip)

		self.address = "#{location.city_name}, #{location.real_region_name}"
		self.latitude = location.latitude
		self.longitude = location.longitude
		self.coordinates = [location.longitude, location.latitude]

	end
end
