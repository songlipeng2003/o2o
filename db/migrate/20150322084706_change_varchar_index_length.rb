class ChangeVarcharIndexLength < ActiveRecord::Migration
  def change
    change_table :active_admin_comments do |t|
      t.change :namespace, :string, limit: 191
      t.change :resource_type, :string, limit: 191
      t.change :author_type, :string, limit: 191
    end

    change_table :admin_users do |t|
      t.change :email, :string, limit: 191
      t.change :reset_password_token, :string, limit: 191
    end

    change_table :areas do |t|
      t.change :ancestry, :string, limit: 191
    end

    change_table :images do |t|
      t.change :item_type, :string, limit: 191
    end

    change_table :users do |t|
      t.change :email, :string, limit: 191
      t.change :reset_password_token, :string, limit: 191
      t.change :authentication_token, :string, limit: 191
    end

    change_table :versions do |t|
      t.change :item_type, :string, limit: 191
    end
  end
end
