class CreateBigCustomerUsers < ActiveRecord::Migration
  def change
    create_table :big_customer_users do |t|
      t.references :big_customer, index: true
      t.string :username
      t.string :phone
      t.string :email
      t.string :encrypted_password
      t.integer :sign_in_count
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string :current_sign_in_ip
      t.string :last_sign_in_ip
      t.string :authentication_token

      t.timestamps
    end
  end
end
