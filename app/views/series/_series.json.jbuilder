json.extract! series, :id, :name, :sinopsis, :director, :imagen, :created_at, :updated_at
json.url series_url(series, format: :json)
