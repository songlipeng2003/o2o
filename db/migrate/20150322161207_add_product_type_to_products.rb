class AddProductTypeToProducts < ActiveRecord::Migration
  def change
    change_table :products do |t|
      t.integer :product_type, default: 1
    end
  end
end
