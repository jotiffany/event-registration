json.array!(@seats) do |seat|
  json.extract! seat, :id, :occupied, :table_id
  json.url seat_url(seat, format: :json)
end
