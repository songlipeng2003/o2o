class CreateStores < ActiveRecord::Migration
  def change
    create_table :stores do |t|
      t.string :name
      t.string :phone
      t.string :address
      t.string :description
      t.float :good_rate, :default => 0
      t.integer :collect_count, :default => 0
      t.float :score, :default => 0

      t.timestamps
    end
  end
end
