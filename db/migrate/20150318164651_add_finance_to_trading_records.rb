class AddFinanceToTradingRecords < ActiveRecord::Migration
  def change
    change_table :trading_records do |t|
      t.remove :user_id
      t.references :finance, index: true
    end
  end
end
