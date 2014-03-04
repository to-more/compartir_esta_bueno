class Mapa
  include Mongoid::Document
  include Geocoder::Model::Mongoid
  has_many :node
  field :coordinates, :type => Array
  field :address
  geocoded_by :address
end
