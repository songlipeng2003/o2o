class AddProductToSystemMonthCard < ActiveRecord::Migration
  def change
    change_table :system_month_cards do |t|
      t.references :product, index: true
    end
  end
end
