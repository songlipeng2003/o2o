class AddPriceToWashMachines < ActiveRecord::Migration
  def change
    change_table :wash_machines do |t|
      t.integer :price
    end
  end
end
