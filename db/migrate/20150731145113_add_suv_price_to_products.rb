class AddSuvPriceToProducts < ActiveRecord::Migration[4.2]
  def change
    change_table :products do |t|
      t.float :suv_price
    end
  end
end
