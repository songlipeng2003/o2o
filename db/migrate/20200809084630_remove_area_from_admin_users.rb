class RemoveAreaFromAdminUsers < ActiveRecord::Migration[6.0]
  def change
    change_table :admin_users do |t|
      t.remove :province_id, :city_id, :area_id
    end
  end
end
