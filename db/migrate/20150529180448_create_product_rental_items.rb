class CreateProductRentalItems < ActiveRecord::Migration
  def change
    create_table :product_rental_items do |t|
      t.integer :product_rental_id
      t.integer :product_id

      t.timestamps
    end
  end
end
