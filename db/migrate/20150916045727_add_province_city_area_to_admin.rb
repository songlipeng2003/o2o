class AddProvinceCityAreaToAdmin < ActiveRecord::Migration
  def change
    change_table :admin_users do |t|
      t.references :province
      t.references :city
      t.references :area
    end
  end
end
