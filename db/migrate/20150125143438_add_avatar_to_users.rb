class AddAvatarToUsers < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.string :avatar
    end
  end
end
