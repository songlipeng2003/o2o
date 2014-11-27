class CreateAreas < ActiveRecord::Migration
  def change
    create_table :areas do |t|
      t.string :name
      t.references :parent, index: true

      t.timestamps
    end
  end
end
