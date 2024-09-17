class CreateSeries < ActiveRecord::Migration[7.2]
  def change
    create_table :series do |t|
      t.string :name
      t.string :sinopsis
      t.string :director
      t.text :imagen

      t.timestamps
    end
  end
end
