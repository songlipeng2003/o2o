class CreateUserStores < ActiveRecord::Migration
  def change
    create_table :user_stores do |t|
      t.references :user, index: true
      t.references :store, index: true

      t.timestamps
    end
  end
end
