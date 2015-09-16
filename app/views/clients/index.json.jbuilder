json.array!(@clients) do |client|
  json.extract! client, :id, :name, :surname, :patronymic, :birth_date, :phone, :stage, :meeting_date, :operator_status, :operator_comment, :partner_status, :partner_comment, :user_id
  json.url client_url(client, format: :json)
end
