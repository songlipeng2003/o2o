class AddApplicationToLoginHistories < ActiveRecord::Migration[4.2]
  def change
    change_table :login_histories do |t|
      t.references :application
    end

    LoginHistory.joins("LEFT JOIN users ON login_histories.user_id=users.id")
      .where(user_type: 'User').update_all("login_histories.application_id=users.application_id");
  end
end
