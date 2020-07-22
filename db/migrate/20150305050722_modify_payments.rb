class ModifyPayments < ActiveRecord::Migration[4.2]
  def change
    change_table :payments do |t|
      t.boolean :is_show, default: true
    end
  end
end
