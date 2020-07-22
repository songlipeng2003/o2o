class AddNumberToRechargePoliciesSystemCoupons < ActiveRecord::Migration[4.2]
  def change
    change_table :recharge_policies_system_coupons do |t|
      t.integer :number, default: 1
    end
  end
end
