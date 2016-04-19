json.array!(@accounts) do |account|
  json.extract! account, :id, :name, :warning_limit, :notified, :user_id
  json.url account_url(account, format: :json)
end
