class RemovePriceToWashMachine < ActiveRecord::Migration
  def change
    change_table :wash_machines do |t|
      t.remove :price
    end
  end
end
