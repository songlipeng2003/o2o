class AddImageToProductsAndSystemCoupons < ActiveRecord::Migration
  def change
    change_table :products do |t|
      t.string :image
    end

    change_table :system_coupons do |t|
      t.string :image
    end
  end
end
