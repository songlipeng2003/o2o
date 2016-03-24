class ChangePriceTypeToWashMachineSet < ActiveRecord::Migration
  def change
    change_table :wash_machine_sets do |t|
      t.change :price, :float
    end
  end
end
