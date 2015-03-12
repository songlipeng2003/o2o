class AddSnToOrders < ActiveRecord::Migration
  def change
    change_table :orders do |t|
      t.string :sn, after: :id
    end
  end
end
