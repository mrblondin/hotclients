json.array!(@users) do |user|
  json.extract! user, :id, :login, :password, :role, :name, :surname
  json.url user_url(user, format: :json)
end
