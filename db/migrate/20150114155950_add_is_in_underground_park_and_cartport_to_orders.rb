class AddIsInUndergroundParkAndCartportToOrders < ActiveRecord::Migration
  def change
    change_table :orders do |t|
      t.boolean :is_underground_park, default: false
      t.string :carport
    end
  end
end
