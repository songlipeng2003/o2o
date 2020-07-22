class AddDeletedAtToStore < ActiveRecord::Migration[4.2]
  def change
    change_table :stores do |t|
      t.datetime :deleted_at
    end
  end
end
