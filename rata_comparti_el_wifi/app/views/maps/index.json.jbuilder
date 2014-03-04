json.array!(@maps) do |map|
  json.extract! map, :id, :address, :latitude, :longitude
  json.url map_url(map, format: :json)
end
