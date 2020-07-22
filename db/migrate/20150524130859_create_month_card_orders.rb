class CreateMonthCardOrders < ActiveRecord::Migration[4.2]
  def change
    create_table :month_card_orders do |t|
      t.references :user, index: true
      t.references :system_month_card, index: true
      t.references :car, index: true
      t.integer :month
      t.integer :price
      t.string :state
      t.references :application, index: true

      t.timestamps
    end
  end
end
