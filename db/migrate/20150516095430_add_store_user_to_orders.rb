class AddStoreUserToOrders < ActiveRecord::Migration[4.2]
  def change
    change_table :orders do |t|
      t.references :store_user
    end
  end
end
