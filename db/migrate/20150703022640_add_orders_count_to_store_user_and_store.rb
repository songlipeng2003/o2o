class AddOrdersCountToStoreUserAndStore < ActiveRecord::Migration
  def change
    change_table :stores do |t|
      t.integer :orders_count, default: 0
    end

    change_table :store_users do |t|
      t.integer :orders_count, default: 0
    end

    change_table :users do |t|
      t.integer :orders_count, default: 0
    end
  end
end
