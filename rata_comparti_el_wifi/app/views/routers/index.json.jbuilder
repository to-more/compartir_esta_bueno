json.array!(@routers) do |router|
  json.extract! router, :id, :mac, :essid, :online, :ip
  json.url router_url(router, format: :json)
end
