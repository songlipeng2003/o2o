class AddSnToOrders < ActiveRecord::Migration[4.2]
  def change
    change_table :orders do |t|
      t.string :sn, after: :id
    end
  end
end
