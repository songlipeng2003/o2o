class AddCarStyleToCars < ActiveRecord::Migration[4.2]
  def change
    change_table :cars do |t|
      t.references :car_style, index: true
    end
  end
end
