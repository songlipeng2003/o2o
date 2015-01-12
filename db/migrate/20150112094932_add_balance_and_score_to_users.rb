class AddBalanceAndScoreToUsers < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.float :balance, default: 0
      t.float :score, default: 0
    end
  end
end
