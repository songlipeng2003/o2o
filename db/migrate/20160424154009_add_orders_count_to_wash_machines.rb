class AddOrdersCountToWashMachines < ActiveRecord::Migration[4.2]
  def change
    change_table :wash_machines do |t|
      t.integer :orders_count, default: 0
      t.change :score, :integer, default: 5
    end
  end
end
