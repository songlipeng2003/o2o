class CreateCarModels < ActiveRecord::Migration
  def change
    create_table :car_models do |t|
      t.string :name
      t.reference :car_brand

      t.timestamps
    end
  end
end
