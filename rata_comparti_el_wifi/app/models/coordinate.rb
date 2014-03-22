
class Coordinate
  
  include Mongoid::Document
  field :x, type: Integer
  field :y, type: Integer
  embedded_in :location
end
