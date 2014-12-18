class AddLocationToStores < ActiveRecord::Migration
  def change
    change_table :stores do |t|
      t.float :lat
      t.float :lon
    end
  end
end
