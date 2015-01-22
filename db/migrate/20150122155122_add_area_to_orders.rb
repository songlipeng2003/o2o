class AddAreaToOrders < ActiveRecord::Migration
  def change
    change_table :orders do |t|
      t.references :province
      t.references :city
      t.references :area
    end
  end
end
