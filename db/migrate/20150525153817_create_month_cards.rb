class CreateMonthCards < ActiveRecord::Migration[4.2]
  def change
    create_table :month_cards do |t|
      t.references :user, index: true
      t.references :car, index: true
      t.string :license_tag
      t.datetime :started_at
      t.datetime :expired_at
      t.string :use_count, default: 0
      t.string :state
      t.references :application

      t.timestamps
    end

    change_table :orders do |t|
      t.references :month_card
    end
  end
end
