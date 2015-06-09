class Rename3d < ActiveRecord::Migration
  def change
    remove_column :systems, :'3d'
    add_column :systems, :three_d, :boolean
  end
end
