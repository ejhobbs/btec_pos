class CreateMembers < ActiveRecord::Migration
  def change
    create_table :members do |t|
      t.string :title
      t.string :first_name
      t.string :surname
      t.string :house_no
      t.string :street_name
      t.string :postcode
      t.date :date_of_birth
      t.integer :member_type_id
      t.string :contact_no

      t.timestamps
    end
  end
end
