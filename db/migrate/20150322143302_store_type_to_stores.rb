class StoreTypeToStores < ActiveRecord::Migration[4.2]
  def change
    change_table :stores do |t|
      t.integer :store_type, default: 1
      t.remove :service_area
    end
  end
end
