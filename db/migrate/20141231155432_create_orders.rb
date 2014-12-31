class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.references :user
      t.references :store
      t.references :car
      t.string :phone
      t.string :address
      t.float :lat
      t.float :lon
      t.datetime :book_at
      t.string :note

      t.timestamps
    end
  end
end
