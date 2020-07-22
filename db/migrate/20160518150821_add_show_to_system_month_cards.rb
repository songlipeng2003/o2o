class AddShowToSystemMonthCards < ActiveRecord::Migration[4.2]
  def change
    change_table :system_month_cards do |t|
      t.boolean :is_show, default: true
    end
  end
end
