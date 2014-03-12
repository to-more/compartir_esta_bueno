json.array!(@nodes) do |node|
  json.extract! node, :id, :router, :location, :link
  json.url node_url(node, format: :json)
end
