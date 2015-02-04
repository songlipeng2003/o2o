class CreateSystemCoupons < ActiveRecord::Migration
  def change
    create_table :system_coupons do |t|
      t.string :name
      t.references :product, index: true
      t.float :amount
      t.string :description

      t.timestamps
    end
  end
end
