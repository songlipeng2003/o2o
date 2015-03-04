class CreateFinances < ActiveRecord::Migration
  def change
    create_table :finances do |t|
      t.references :user, polymorphic: true
      t.float :balance
      t.float :freeze

      t.timestamps
    end

    change_table :trading_records do |t|
      t.string :name, after: :amount
      t.float :start_amount
      t.float :end_amount
    end
  end
end
