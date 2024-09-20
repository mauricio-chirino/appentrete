# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require 'themoviedb-api'
require 'json'
require 'faker'



# Método para obtener y crear películas
def seed_films
  puts "Fetching and seeding films..."
  films = Tmdb::Movie.popular(page: 3)["results"].take(20)
  films.each do |film|
    # El objeto film ya es un hash, no necesitas 'original_title' directamente
    #puts "Título original: #{film['original_title']}" # Aquí se obtiene 'original_title'
    # puts "Sinopsis: #{film['overview']}"
    # puts "imagen: #{film['poster_path']}"
    # puts " id pelicula :  #{film['id']}"
       

    #grabar los datos en la base Films
    director = get_director()
    Film.create(
      name: film["title"],
      sinopsis: film["overview"],
      director: director,
      imagen: "https://image.tmdb.org/t/p/w500#{film['poster_path']}"
      )
  end
end

# Método para obtener y crear series
def seed_series
  puts "Fetching and seeding series..."
  series_nombre = Tmdb::TV.popular(page: 1)["results"].take(50)
  director = get_director() 
  
  series_nombre.each do |serie|
    Series.create(
      name: serie["name"],
      sinopsis: serie["overview"],
      director: director,
      imagen: "https://image.tmdb.org/t/p/w500#{serie['poster_path']}"
    )
  end
end

# Método para obtener y crear documentales
def seed_documentaries
  puts "Fetching and seeding documentaries..."
  documentaries = Tmdb::Discover.movie(with_genres: 99, page: 1)["results"].take(50)
  
  documentaries.each do |doc|
    director = get_director()
    DocumentaryFilm.create(
      name: doc["title"],
      sinopsis: doc["overview"],
      director: director,
      imagen: "https://image.tmdb.org/t/p/w500#{doc['poster_path']}"
    )
  end
end


# Obtenemos un nombre desde faker para agregarlo como director 
def get_director()
  directores = 1.times.map { Faker::Name.name }
  directores.each { |director| return "#{director}" }
end


# Ejecutar los métodos para poblar la base de datos
seed_films
seed_series
seed_documentaries

puts "Seeding completed!"
  
