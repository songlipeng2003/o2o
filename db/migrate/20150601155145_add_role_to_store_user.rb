class AddRoleToStoreUser < ActiveRecord::Migration[4.2]
  def change
    change_table :store_users do |t|
      t.integer :role, default: '1'
    end
  end
end
