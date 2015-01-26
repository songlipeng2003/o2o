class AddOriginalPriceToOrders < ActiveRecord::Migration
  def change
    change_table :orders do |t|
      t.float :original_price
    end
  end
end
