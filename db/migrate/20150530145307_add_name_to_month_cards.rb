class AddNameToMonthCards < ActiveRecord::Migration
  def change
    change_table :month_cards do |t|
      t.string :name
    end
  end
end
