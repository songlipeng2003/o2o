class AddClosedAtToRecharges < ActiveRecord::Migration[4.2]
  def change
    change_table :recharges do |t|
      t.datetime :closed_at
    end
  end
end
