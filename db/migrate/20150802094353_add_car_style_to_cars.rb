class AddCarStyleToCars < ActiveRecord::Migration
  def change
    change_table :cars do |t|
      t.references :car_style, index: true
    end
  end
end
