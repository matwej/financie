json.array!(@transactions) do |transaction|
  json.extract! transaction, :id, :account, :processing_date, :description, :amount, :category_id, :account_id
  json.url transaction_url(transaction, format: :json)
end
