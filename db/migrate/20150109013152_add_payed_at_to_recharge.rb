class AddPayedAtToRecharge < ActiveRecord::Migration
  def change
    change_table :recharge do |t|
      t.datetime :payed_at
    end
  end
end
