class AddGenderAndNicknameToUsers < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.string :gender
      t.string :nickname
    end
  end
end
