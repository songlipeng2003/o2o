class RemoveUmengFromApplication < ActiveRecord::Migration
  def change
    change_table :applications do |t|
      t.remove :umeng_app_key
      t.remove :app_master_secret
    end
  end
end
