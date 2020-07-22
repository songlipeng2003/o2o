class CreateSystemCoupons < ActiveRecord::Migration[4.2]
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
