class Router
  include Mongoid::Document
  field :mac, type: String
  field :essid, type: String
  field :online, type: Mongoid::Boolean
  field :ip, type: String
  field :password, type: String

  embedded_in :node

  after_initialize :set_online

  def set_online
  	self.online = false
  end

end
