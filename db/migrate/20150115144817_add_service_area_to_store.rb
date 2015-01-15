class AddServiceAreaToStore < ActiveRecord::Migration
  def change
    change_table :stores do |t|
      t.text :service_area
    end
  end
end
