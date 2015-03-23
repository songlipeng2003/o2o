class AddStoreToProducts < ActiveRecord::Migration
  def change
    change_table :products do |t|
      t.references :store
    end
  end
end
