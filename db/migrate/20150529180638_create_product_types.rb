class CreateProductTypes < ActiveRecord::Migration
  def change
    create_table :product_types do |t|
      t.string :easy_name
      t.decimal :price

      t.timestamps
    end
  end
end
