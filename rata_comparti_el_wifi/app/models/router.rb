class Router
  include Mongoid::Document
  field :mac, type: String
  field :essid, type: String
  field :online, type: Mongoid::Boolean
  field :ip, type: String
end
