class CreateTradingRecords < ActiveRecord::Migration
  def change
    create_table :trading_records do |t|
      t.references :user, index: true
      t.integer :type
      t.integer :amount
      t.references :object, polymorphic: true
      t.string :remark

      t.datetime :created_at
    end
  end
end
