class AddUserToLoginHistories < ActiveRecord::Migration
  def change
    change_table :login_histories do |t|
      t.remove :user_id
      t.references :user, polymorphic:true
    end
  end
end
