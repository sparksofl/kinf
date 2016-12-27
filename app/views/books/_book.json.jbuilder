json.extract! book, :id, :title, :present, :date_given, :created_at, :updated_at
json.url book_url(book, format: :json)