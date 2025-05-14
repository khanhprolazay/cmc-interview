json.array!(@models) do |asset|
    json.id asset.id
    json.title asset.title
    json.description asset.description
    json.price asset.price
end
