class AddDeletedAtToStore < ActiveRecord::Migration
  def change
    change_table :stores do |t|
      t.datetime :deleted_at
    end
  end
end
