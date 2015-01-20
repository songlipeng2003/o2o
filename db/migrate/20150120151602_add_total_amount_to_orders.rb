class AddTotalAmountToOrders < ActiveRecord::Migration
  def change
    change_table :orders do |t|
      t.float :total_amount
    end
  end
end
