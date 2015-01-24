class AddUserAndStoreToEvaluation < ActiveRecord::Migration
  def change
    change_table :evaluations do |t|
      t.references :user
      t.references :store
    end
  end
end
