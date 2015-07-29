class RemoveEmailIndexToUsers < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.remove_index :email
    end
  end
end
