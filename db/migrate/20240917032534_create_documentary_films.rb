class CreateDocumentaryFilms < ActiveRecord::Migration[7.2]
  def change
    create_table :documentary_films do |t|
      t.string :name
      t.string :sinopsis
      t.string :director
      t.text :imagen

      t.timestamps
    end
  end
end
