class CreateNotifyLogs < ActiveRecord::Migration[4.2]
  def change
    create_table :notify_logs do |t|
      t.references :payment, index: true
      t.string :type
      t.text :params

      t.timestamps
    end
  end
end
