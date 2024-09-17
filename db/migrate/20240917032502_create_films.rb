class CreateFilms < ActiveRecord::Migration[7.2]
  def change
    create_table :films do |t|
      t.string :name
      t.string :sinopsis
      t.string :director
      t.text :imagen

      t.timestamps
    end
  end
end
