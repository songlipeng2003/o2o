class AddIsIncludeInteriorAndProductTypeToOrders < ActiveRecord::Migration
  def change
    change_table :orders do |t|
      t.integer :product_type, default: 1
      t.boolean :is_include_interior, default: 0
    end

    change_table :products do |t|
      t.integer :product_type, default: 1
    end
  end
end
