class CreateProductRentals < ActiveRecord::Migration
  def change
    create_table :product_rentals do |t|
      t.integer :member_id
      t.date :start_date
      t.date :due_date
      t.boolean :returned
      t.decimal :total_price
      t.decimal :late_fees

      t.timestamps
    end
  end
end
