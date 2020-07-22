class RemoveEmailIndexToUsers < ActiveRecord::Migration[4.2]
  def change
    change_table :users do |t|
      t.remove_index :email
    end
  end
end
