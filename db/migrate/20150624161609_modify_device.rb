class ModifyDevice < ActiveRecord::Migration[4.2]
  def change
    change_table :devices do |t|
      t.references :deviceable, polymorphic: true
      t.string :device_type
      t.string :jpush
      t.remove :user_id
      t.remove :type
    end
  end
end
