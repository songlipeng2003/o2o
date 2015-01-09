class AddPayedAtToRecharge < ActiveRecord::Migration
  def change
    change_table :recharges do |t|
      t.datetime :payed_at
    end
  end
end
