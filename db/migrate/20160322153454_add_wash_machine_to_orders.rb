class AddWashMachineToOrders < ActiveRecord::Migration[4.2]
  def change
    change_table :orders do |t|
      t.references :wash_machine, index: true
      t.references :wash_machine_set, index: true
      t.integer :order_type, default: 1
      t.string :wash_machine_code
    end
  end
end
