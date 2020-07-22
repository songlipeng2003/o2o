class AddUserToLoginHistories < ActiveRecord::Migration[4.2]
  def change
    change_table :login_histories do |t|
      t.remove :user_id
      t.references :user, polymorphic:true
    end
  end
end
