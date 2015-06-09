class AddUpgradeDateToMember < ActiveRecord::Migration
  def change
    change_table :members do |t|
      t.date :upgrade_date
    end
  end
end
