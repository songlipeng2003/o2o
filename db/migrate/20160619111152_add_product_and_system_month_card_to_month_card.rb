class AddProductAndSystemMonthCardToMonthCard < ActiveRecord::Migration[4.2]
  def change
    change_table :month_cards do |t|
      t.references :product, index: true
      t.references :system_month_card, index: true
    end
  end
end
