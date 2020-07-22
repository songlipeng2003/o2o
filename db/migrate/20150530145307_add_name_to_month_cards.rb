class AddNameToMonthCards < ActiveRecord::Migration[4.2]
  def change
    change_table :month_cards do |t|
      t.string :name
    end
  end
end
