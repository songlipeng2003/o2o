class AddProvinceAndCityToProduct < ActiveRecord::Migration
  def change
    change_table :products do |t|
      t.references :province, index: true, default: 916
      t.references :city, index: true, default: 917
    end
  end
end
