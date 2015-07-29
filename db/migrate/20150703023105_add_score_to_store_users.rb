class AddScoreToStoreUsers < ActiveRecord::Migration
  def change
    change_table :store_users do |t|
      t.float :score, default: 0
    end
  end
end
