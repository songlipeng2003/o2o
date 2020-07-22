class AddScoreToWashMachine < ActiveRecord::Migration[4.2]
  def change
    change_table :wash_machines do |t|
      t.float :score
    end

    change_table :evaluations do |t|
      t.references :wash_machine
    end
  end
end
