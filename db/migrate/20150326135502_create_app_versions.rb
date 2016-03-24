class CreateAppVersions < ActiveRecord::Migration
  def change
    create_table :app_versions do |t|
      t.string :file
      t.string :version
      t.text :description

      t.timestamps
    end
  end
end
