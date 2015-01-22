class AddAreaToStores < ActiveRecord::Migration
  def change
    change_table :stores do |t|
      t.references :province
      t.references :city
      t.references :area
    end
  end
end
