class AddOrderAmountToOrders < ActiveRecord::Migration
  def change
    change_table :orders do |t|
      t.float :order_amount
    end

    Order.update_all("order_amount=total_amount");
  end
end
