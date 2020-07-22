class AddIdToRechargePoliciesSystemCoupons < ActiveRecord::Migration[4.2]
  def change
    add_column :recharge_policies_system_coupons, :id, :primary_key
  end
end
