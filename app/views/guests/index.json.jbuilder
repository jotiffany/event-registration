json.array!(@guests) do |guest|
  json.extract! guest, :id, :name
end
