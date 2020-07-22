class CreateSystemProducts < ActiveRecord::Migration[4.2]
  def change
    create_table :system_products do |t|
      t.string :name
      t.string :description
      t.references :category, index: true
      t.string :image

      t.timestamps
    end
  end
end
