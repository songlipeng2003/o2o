class AddStoreUserToOrders < ActiveRecord::Migration
  def change
    change_table :orders do |t|
      t.references :store_user
    end
  end
end
