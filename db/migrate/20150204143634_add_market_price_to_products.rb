class AddMarketPriceToProducts < ActiveRecord::Migration[4.2]
  def change
    change_table :products do |t|
      t.float :market_price
    end
  end
end
