class AddMarketPriceToProducts < ActiveRecord::Migration
  def change
    change_table :products do |t|
      t.float :market_price
    end
  end
end
