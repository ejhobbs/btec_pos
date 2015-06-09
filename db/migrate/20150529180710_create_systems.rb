class CreateSystems < ActiveRecord::Migration
  def change
    create_table :systems do |t|
      t.text :description
      t.decimal :audio_setup
      t.boolean :hd
      t.boolean :'3d'
      t.decimal :base_price

      t.timestamps
    end
  end
end
