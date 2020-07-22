class ChangePriceTypeToWashMachineSet < ActiveRecord::Migration[4.2]
  def change
    change_table :wash_machine_sets do |t|
      t.change :price, :float
    end
  end
end
