class AddSystemProductToProducts < ActiveRecord::Migration[4.2]
  def change
    change_table :products do |t|
      t.references :system_product, index: true
    end
  end
end
