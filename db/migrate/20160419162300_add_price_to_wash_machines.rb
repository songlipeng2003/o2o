class AddPriceToWashMachines < ActiveRecord::Migration[4.2]
  def change
    change_table :wash_machines do |t|
      t.integer :price
    end
  end
end
