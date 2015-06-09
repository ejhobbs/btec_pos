class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.integer :product_type_id
      t.string :name
      t.string :imdb_id
      t.string :age_rating
      t.decimal :star_rating
      t.text :synopsis

      t.timestamps
    end
  end
end
