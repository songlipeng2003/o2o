class AddDeletedAtToOrders < ActiveRecord::Migration
  def change
    change_table :orders do |t|
      t.datetime :deleted_at
      t.index :deleted_at
    end
  end
end
