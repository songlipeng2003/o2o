class CreateServiceAreas < ActiveRecord::Migration
  def change
    create_table :service_areas do |t|
      t.references :product, index: true
      t.string :name
      t.string :areas

      t.timestamps
    end
  end
end
