class CreateLoginHistories < ActiveRecord::Migration
  def change
    create_table :login_histories do |t|
      t.references :user, index: true
      t.string :devise
      t.string :devise_type
      t.string :ip

      t.timestamps
    end
  end
end
