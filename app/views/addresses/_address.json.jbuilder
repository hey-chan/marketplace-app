json.extract! address, :id, :user_id, :street_name, :suburb, :postcode, :state, :country, :created_at, :updated_at
json.url address_url(address, format: :json)
