class AddRegionInfoWashMachine < ActiveRecord::Migration
  def change
    change_table :wash_machines do |t|
      t.references :province
      t.references :city
      t.references :area
    end
  end
end
