json.array!(@clients) do |client|
  json.extract! client, :id, :name, :surname, :patronymic, :birth_date, :phone, :stage, :meeting_date, :operator_status, :operator_comment, :partner_status, :partner_comment, :user_id, :status_date, :transfer_date, :passport_number, :passport_issued, :passport_date, :birth_place, :sex
  json.url client_url(client, format: :json)
end
