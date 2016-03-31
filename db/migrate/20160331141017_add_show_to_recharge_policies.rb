class AddShowToRechargePolicies < ActiveRecord::Migration
  def change
    change_table :recharge_policies do |t|
      t.boolean :show, default: true
    end
  end
end
