class AddAvatarToStoreUser < ActiveRecord::Migration
  def change
    change_table :store_users do |t|
      t.string :avatar
    end
  end
end
