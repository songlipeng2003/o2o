class RemoveBalanceFromUsers < ActiveRecord::Migration[4.2]
  def change
    change_table :users do |t|
      t.remove :balance
    end
  end
end
