class AddSuvPriceToProducts < ActiveRecord::Migration
  def change
    change_table :products do |t|
      t.float :suv_price
    end
  end
end
