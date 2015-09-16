json.array!(@cities) do |city|
  json.extract! city, :id, :region, :city, :city_code, :user_id
  json.url city_url(city, format: :json)
end
