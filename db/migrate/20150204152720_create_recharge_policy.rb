class CreateRechargePolicy < ActiveRecord::Migration
  def change
    create_join_table :recharge_policies, :system_coupons
  end
end
