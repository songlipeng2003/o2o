class AddAppMasterSecretToApplications < ActiveRecord::Migration[4.2]
  def change
    change_table :applications do |t|
      t.string :app_master_secret
    end
  end
end
