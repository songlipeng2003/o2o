class DropProductTypes < ActiveRecord::Migration
  def change
    drop_table :product_types
    change_table :products do |t|
      t.remove :product_type_id
    end

    change_table :system_coupons do |t|
      t.remove :product_type_id
    end
  end
end
