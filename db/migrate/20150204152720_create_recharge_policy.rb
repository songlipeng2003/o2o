class CreateRechargePolicy < ActiveRecord::Migration[4.2]
  def change
    create_join_table :recharge_policies, :system_coupons
  end
end
