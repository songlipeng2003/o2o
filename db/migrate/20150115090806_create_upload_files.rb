class CreateUploadFiles < ActiveRecord::Migration
  def change
    create_table :upload_files do |t|
      t.string :file
      t.integer :filesize

      t.datetime :created_at
    end
  end
end
