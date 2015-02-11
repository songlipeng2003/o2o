class CreateStoreUsers < ActiveRecord::Migration
  def change
    create_table :store_users do |t|
      t.references :store, index: true
      t.string :username
      t.string :phone
      t.string :email,                  default: "", null: false
      t.string :encrypted_password,     default: "", null: false
      t.integer :sign_in_count,          default: 0,  null: false
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string :current_sign_in_ip
      t.string :last_sign_in_ip
      t.string :authentication_token
      t.string :gender
      t.string :nickname

      t.timestamps
    end
  end
end
