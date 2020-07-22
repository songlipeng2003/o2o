class AddUmengAppKeyAndAppTypeToApplications < ActiveRecord::Migration[4.2]
  def change
    change_table :applications do |t|
      t.string :umeng_app_key
      t.string :app_type
    end
  end
end
