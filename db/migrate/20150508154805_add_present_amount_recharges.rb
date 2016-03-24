class AddPresentAmountRecharges < ActiveRecord::Migration
  def change
    change_table :recharges do |t|
      t.integer :present_amount
    end

    Recharge.joins(:recharge_policy).update_all("recharges.present_amount=recharge_policies.present_amount");
  end
end
