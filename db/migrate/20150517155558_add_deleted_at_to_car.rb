class AddDeletedAtToCar < ActiveRecord::Migration
  def change
    change_table :cars do |t|
      t.datetime :deleted_at
    end
  end
end
