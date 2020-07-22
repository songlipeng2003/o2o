class AddImageToProductsAndSystemCoupons < ActiveRecord::Migration[4.2]
  def change
    change_table :products do |t|
      t.string :image
    end

    change_table :system_coupons do |t|
      t.string :image
    end
  end
end
