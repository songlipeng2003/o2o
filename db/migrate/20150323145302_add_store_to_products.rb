class AddStoreToProducts < ActiveRecord::Migration[4.2]
  def change
    change_table :products do |t|
      t.references :store
    end
  end
end
