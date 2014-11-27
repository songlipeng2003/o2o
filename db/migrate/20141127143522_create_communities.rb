class CreateCommunities < ActiveRecord::Migration
  def change
    create_table :communities do |t|
      t.string :name
      t.string :address
      t.references :area, index: true

      t.timestamps
    end
  end
end
