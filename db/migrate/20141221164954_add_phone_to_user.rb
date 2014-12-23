class AddPhoneToUser < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.string :phone
    end
  end
end
