class Location
	
	include Mongoid::Document
	include Geocoder::Model::Mongoid
	field :ip, type: String
	field :address, type: String
	field :latitude, type: Float
	field :longitude, type: Float
	field :coordinates, :type => Array

	embedded_in :node

  	geocoded_by :address 

 	after_initialize :set_location

	after_validation :geocode 

	def set_location

		if self.address then
			search = Geocoder.search(self.address)		
			result =  search.first
			if result
				self.latitude = result.latitude
				self.longitude = result.longitude
			end
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
