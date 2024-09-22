class AddCategoriaToFilmsSeriesAndDocumentaryFilms < ActiveRecord::Migration[7.2]
  def change
    add_column :films, :categoria, :integer, limit: 1
    add_column :series, :categoria, :integer, limit: 1
    add_column :documentary_films, :categoria, :integer, limit: 1
  end
end
