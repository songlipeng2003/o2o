class AddProductTypeToProducts < ActiveRecord::Migration[4.2]
  def change
    change_table :products do |t|
      t.integer :product_type, default: 1
    end
  end
end
