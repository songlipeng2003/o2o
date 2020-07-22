class CreateWashMachineSets < ActiveRecord::Migration[4.2]
  def change
    create_table :wash_machine_sets do |t|
      t.string :price
      t.string :name
      t.string :image
      t.string :description

      t.timestamps
    end
  end
end
