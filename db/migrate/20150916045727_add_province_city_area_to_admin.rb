class AddProvinceCityAreaToAdmin < ActiveRecord::Migration[4.2]
  def change
    change_table :admin_users do |t|
      t.references :province
      t.references :city
      t.references :area
    end
  end
end
