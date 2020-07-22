class CreateAppVersions < ActiveRecord::Migration[4.2]
  def change
    create_table :app_versions do |t|
      t.string :file
      t.string :version
      t.text :description

      t.timestamps
    end
  end
end
