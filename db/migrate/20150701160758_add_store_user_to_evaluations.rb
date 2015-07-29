class AddStoreUserToEvaluations < ActiveRecord::Migration
  def change
    change_table :evaluations do |t|
      t.references :store_user, index: true
      t.integer :score1
      t.integer :score2
      t.integer :score3
    end
  end
end
