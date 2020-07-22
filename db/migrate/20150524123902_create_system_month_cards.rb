class CreateSystemMonthCards < ActiveRecord::Migration[4.2]
  def change
    create_table :system_month_cards do |t|
      t.references :province, index: true
      t.references :city, index: true
      t.integer :month
      t.string :name
      t.integer :price
      t.integer :sort, default: 0

      t.timestamps
    end
  end
end
