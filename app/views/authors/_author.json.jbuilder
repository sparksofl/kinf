json.extract! author, :id, :books_id, :first_name, :last_name, :born, :created_at, :updated_at
json.url author_url(author, format: :json)