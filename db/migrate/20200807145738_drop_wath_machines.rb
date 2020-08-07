class DropWathMachines < ActiveRecord::Migration[6.0]
  def change
    drop_table :wash_machines

    change_table :evaluations do |t|
      t.remove :wash_machine_id
    end

    change_table :orders do |t|
      t.remove :wash_machine_id
      t.remove :wash_machine_code
      t.remove :wash_machine_random_code
    end
  end
end
