class ChangeAmountType < ActiveRecord::Migration
  def change
    change_table :trading_records do |t|
      t.change :amount, :float
    end

    change_table :recharges do |t|
      t.change :amount, :float
    end
  end
end
