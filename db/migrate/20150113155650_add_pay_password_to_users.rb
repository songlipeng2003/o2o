class AddPayPasswordToUsers < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.string :encrypted_pay_password
    end
  end
end
