class AddCouponToOrders < ActiveRecord::Migration[4.2]
  def change
    change_table :orders do |t|
      t.references :coupon, index: true
    end
  end
end
