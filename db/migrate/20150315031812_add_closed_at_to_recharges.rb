class AddClosedAtToRecharges < ActiveRecord::Migration
  def change
    change_table :recharges do |t|
      t.datetime :closed_at
    end
  end
end
