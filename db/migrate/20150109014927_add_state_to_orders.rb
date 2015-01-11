class AddStateToOrders < ActiveRecord::Migration
  def change
    change_table :orders do |t|
      t.string :state
    end
  end
end
