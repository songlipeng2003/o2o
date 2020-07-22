class DropWashMachineSets < ActiveRecord::Migration[4.2]
  def change
    drop_table :wash_machine_sets

    change_table :orders do |t|
      t.remove :wash_machine_set_id
    end
  end
end
