json.extract! user, :id, :first_name, :last_name, :description, :email, :age, :city_id, :created_at, :updated_at
json.url user_url(user, format: :json)
