class CreateCarStyles < ActiveRecord::Migration[4.2]
  def change
    create_table :car_styles do |t|
      t.references :car_brand, index: true
      t.references :car_model, index: true
      t.string :name

      t.timestamps
    end
  end
end
