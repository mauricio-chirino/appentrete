json.extract! film, :id, :name, :sinopsis, :director, :imagen, :created_at, :updated_at
json.url film_url(film, format: :json)
