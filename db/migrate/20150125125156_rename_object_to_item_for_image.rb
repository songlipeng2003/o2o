class RenameObjectToItemForImage < ActiveRecord::Migration
  def change
    change_table :images do |t|
      t.rename :object_id, :item_id
      t.rename :object_type, :item_type
    end
  end
end
