class AddWashMachineRandomCodeToOrders < ActiveRecord::Migration
  def change
    change_table :orders do |t|
      t.string :wash_machine_random_code
    end
  end
end
