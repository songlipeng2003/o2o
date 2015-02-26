class AddSortToRechargePolicies < ActiveRecord::Migration
  def change
    change_table :recharge_policies do |t|
      t.integer :sort, default: 0
    end
  end
end
