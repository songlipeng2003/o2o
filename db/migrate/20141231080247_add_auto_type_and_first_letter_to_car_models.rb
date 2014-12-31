class AddAutoTypeAndFirstLetterToCarModels < ActiveRecord::Migration
  def change
    change_table :car_models do |t|
      t.string :auto_type
      t.string :first_letter
    end
  end
end
