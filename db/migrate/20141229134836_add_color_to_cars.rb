class AddColorToCars < ActiveRecord::Migration
  def change
    change_table :cars do |t|
      t.string :color
    end
  end
end
