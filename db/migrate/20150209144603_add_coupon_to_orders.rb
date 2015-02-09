class AddCouponToOrders < ActiveRecord::Migration
  def change
    change_table :orders do |t|
      t.references :coupon, index: true
    end
  end
end
