class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :address
      t.string :type
      t.float :lat
      t.float :lon
      t.references :user, index: true

      t.timestamps
    end
  end
end
