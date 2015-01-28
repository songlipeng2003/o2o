class AddDeviceModelToLoginHistories < ActiveRecord::Migration
  def change
    change_table :login_histories do |t|
      t.rename :devise, :device
      t.rename :devise_type, :device_type
      t.string :device_model
    end
  end
end
