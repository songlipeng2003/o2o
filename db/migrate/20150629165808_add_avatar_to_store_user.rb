class AddAvatarToStoreUser < ActiveRecord::Migration[4.2]
  def change
    change_table :store_users do |t|
      t.string :avatar
    end
  end
end
