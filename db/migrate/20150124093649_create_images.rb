class CreateImages < ActiveRecord::Migration
  def change
    create_table :images do |t|
      t.string :file
      t.integer :filesize
      t.references :object, index: true, polymorphic: true

      t.datetime :created_at
    end
  end
end
