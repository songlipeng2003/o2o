class AddFundTypeToTradingRecords < ActiveRecord::Migration
  def change
    change_table :trading_records do |t|
      t.integer :fund_type, null: false, default: 1
    end
  end
end
