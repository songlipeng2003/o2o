class AddCarInfoAndAddressProductToOrders < ActiveRecord::Migration
  def change
    change_table :orders do |t|
      t.string :license_tag
      t.references :car_model
      t.string :car_color
      t.references :address
      t.rename :address, :place
      t.references :product
    end
  end
end
