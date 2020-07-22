class RemovePriceToWashMachine < ActiveRecord::Migration[4.2]
  def change
    change_table :wash_machines do |t|
      t.remove :price
    end
  end
end
