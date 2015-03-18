class RemoveBalanceFromUsers < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.remove :balance
    end
  end
end
