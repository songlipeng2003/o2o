class AddShowToRechargePolicies < ActiveRecord::Migration[4.2]
  def change
    change_table :recharge_policies do |t|
      t.boolean :show, default: true
    end
  end
end
