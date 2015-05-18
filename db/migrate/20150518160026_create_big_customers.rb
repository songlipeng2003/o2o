class CreateBigCustomers < ActiveRecord::Migration
  def change
    create_table :big_customers do |t|
      t.string :name
      t.string :contacts
      t.string :phone
      t.references :province, index: true
      t.references :city, index: true
      t.references :area, index: true

      t.timestamps
    end
  end
end
