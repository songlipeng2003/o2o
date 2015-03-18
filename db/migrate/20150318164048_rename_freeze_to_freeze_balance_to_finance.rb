class RenameFreezeToFreezeBalanceToFinance < ActiveRecord::Migration
  def change
    change_table :finances do |t|
      t.rename :freeze, :freeze_balance
      t.change :freeze_balance, :float, default: 0
      t.change :balance, :float, default: 0
    end
  end
end
