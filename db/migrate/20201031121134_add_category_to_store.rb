class AddCategoryToStore < ActiveRecord::Migration[6.0]
  def change
    change_table :categories do |t|
      t.string :image
      t.integer :sort, default: 255
      t.string :ancestry
      t.integer :ancestry_depth
    end

    change_table :stores do |t|
      t.references :category
    end
  end
end
