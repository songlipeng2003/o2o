class CreateRechargePolicies < ActiveRecord::Migration
  def change
    create_table :recharge_policies do |t|
      t.integer :amount
      t.integer :present_amount
      t.string :note

      t.timestamps
    end
  end
end
