class CreateSystemBookings < ActiveRecord::Migration
  def change
    create_table :system_bookings do |t|
      t.integer :member_id
      t.date :install_date
      t.date :collection_date
      t.boolean :deposit_paid
      t.integer :system_id
      t.decimal :total_cost

      t.timestamps
    end
  end
end
