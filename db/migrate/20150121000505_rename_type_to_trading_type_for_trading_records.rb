class RenameTypeToTradingTypeForTradingRecords < ActiveRecord::Migration
  def change
    change_table :trading_records do |t|
      t.rename :type, :trading_type
    end
  end
end
