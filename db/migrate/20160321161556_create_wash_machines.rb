class CreateWashMachines < ActiveRecord::Migration[4.2]
  def change
    create_table :wash_machines do |t|
      t.string :code
      t.float :lat
      t.float :lon
      t.string :address
      t.string :price

      t.timestamps
    end
  end
end
