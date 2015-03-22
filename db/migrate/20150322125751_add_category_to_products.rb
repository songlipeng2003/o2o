class AddCategoryToProducts < ActiveRecord::Migration
  def change
    change_table :products do |t|
      t.references :category
    end
  end
end
