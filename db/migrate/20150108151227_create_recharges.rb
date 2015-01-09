class CreateRecharges < ActiveRecord::Migration
  def change
    create_table :recharges do |t|
      t.references :user, index: true
      t.integer :amount
      t.string :state

      t.datetime :created_at
    end
  end
end
