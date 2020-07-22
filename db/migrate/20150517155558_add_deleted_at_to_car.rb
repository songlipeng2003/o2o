class AddDeletedAtToCar < ActiveRecord::Migration[4.2]
  def change
    change_table :cars do |t|
      t.datetime :deleted_at
    end
  end
end
