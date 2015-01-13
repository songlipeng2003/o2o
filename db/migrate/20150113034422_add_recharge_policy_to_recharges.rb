class AddRechargePolicyToRecharges < ActiveRecord::Migration
  def change
    change_table :recharges do |t|
      t.references :recharge_policy
    end
  end
end
