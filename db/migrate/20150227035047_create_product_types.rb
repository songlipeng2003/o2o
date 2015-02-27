class CreateProductTypes < ActiveRecord::Migration
  def change
    create_table :product_types do |t|
      t.string :name
      t.string :description

      t.timestamps
    end

    change_table :system_coupons do |t|
      t.references :product_type, index: true
    end

    change_table :products do |t|
      t.remove :product_type
      t.references :product_type, index: true
    end
  end
end
