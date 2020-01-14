json.set! :towns do
  json.array! @towns do |town|
    json.extract! town, *town.attribute_names
  end
end