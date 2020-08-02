class DropSystemProduct < ActiveRecord::Migration[6.0]
  def change
    drop_table :system_products

    change_table :products do |t|
      t.remove :system_product_id
    end
  end
end
