class CreateUserStores < ActiveRecord::Migration[4.2]
  def change
    create_table :user_stores do |t|
      t.references :user, index: true
      t.references :store, index: true

      t.timestamps
    end
  end
end
