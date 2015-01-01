class CreateDevices < ActiveRecord::Migration
  def change
    create_table :devices do |t|
      t.string :code
      t.string :type
      t.references :user, index: true

      t.datetime :created_at
    end
  end
end
