class CreateCoupons < ActiveRecord::Migration[4.2]
  def change
    create_table :coupons do |t|
      t.references :user, index: true
      t.references :system_coupon, index: true
      t.float :amount
      t.string :state
      t.string :expired_at

      t.timestamps
    end
  end
end
