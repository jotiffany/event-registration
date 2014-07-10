json.array!(@guests) do |guest|
  json.extract! guest, :id, :name, :table_id, :assigned_seats, :registered
  json.url guest_url(guest, format: :json)
end
