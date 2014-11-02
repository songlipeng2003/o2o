class CreateCars < ActiveRecord::Migration
  def change
    create_table :cars do |t|
      t.string :license_tag
      t.references :car_model
      t.date :buy_date

      t.timestamps
    end
  end
end
