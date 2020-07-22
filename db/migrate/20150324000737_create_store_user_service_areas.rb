class CreateStoreUserServiceAreas < ActiveRecord::Migration[4.2]
  def change
    create_table :store_user_service_areas do |t|
      t.references :store_user, index: true
      t.references :service_area, index: true

      t.datetime :created_at
    end
  end
end
