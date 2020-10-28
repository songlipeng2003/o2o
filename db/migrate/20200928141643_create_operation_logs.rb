class CreateOperationLogs < ActiveRecord::Migration[6.0]
  def change
    create_table :operation_logs do |t|
      t.references :user, index: true
      t.string :path
      t.string :method
      t.string :ip
      t.references :application
      t.text :data

      t.timestamps
    end
  end
end
