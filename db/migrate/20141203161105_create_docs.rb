class CreateDocs < ActiveRecord::Migration
  def change
    create_table :docs do |t|
      t.string :title
      t.string :key
      t.text :content

      t.timestamps
    end
  end
end
