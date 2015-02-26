class AddIdToRechargePoliciesSystemCoupons < ActiveRecord::Migration
  def change
    add_column :recharge_policies_system_coupons, :id, :primary_key
  end
end
