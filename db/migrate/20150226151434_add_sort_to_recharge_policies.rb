class AddSortToRechargePolicies < ActiveRecord::Migration[4.2]
  def change
    change_table :recharge_policies do |t|
      t.integer :sort, default: 0
    end
  end
end
