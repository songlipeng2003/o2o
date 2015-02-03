class AddAppMasterSecretToApplications < ActiveRecord::Migration
  def change
    change_table :applications do |t|
      t.string :app_master_secret
    end
  end
end
