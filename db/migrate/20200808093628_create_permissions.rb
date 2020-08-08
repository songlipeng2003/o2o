class CreatePermissions < ActiveRecord::Migration[6.0]
  def change
    create_table :permissions do |t|
      t.string :name
      t.string :subject_class
      t.integer :subject_id
      t.string :action
      t.text :description

      t.timestamps
    end

    create_table :roles do |t|
      t.string :name
      t.text :description

      t.timestamps
    end

    create_table :roles_permissions, :id => false do |t|
      t.references :permission
      t.references :role
    end

    add_index :roles_permissions, [:role_id, :permission_id]

    create_table :users_roles, :id => false do |t|
      t.references :user
      t.references :role
    end
    add_index :users_roles, [:user_id, :role_id]
  end
end
