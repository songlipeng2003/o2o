class AddUmengAppKeyAndAppTypeToApplications < ActiveRecord::Migration
  def change
    change_table :applications do |t|
      t.string :umeng_app_key
      t.string :app_type
    end
  end
end
