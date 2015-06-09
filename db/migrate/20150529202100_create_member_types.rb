class CreateMemberTypes < ActiveRecord::Migration
  def change
    create_table :member_types do |t|
      t.string :easy_name
      t.decimal :price
      t.boolean :requires_previous

      t.timestamps
    end
  end
end
