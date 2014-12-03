class AddAncestryToArea < ActiveRecord::Migration
  def self.up
    add_column :areas, :ancestry, :string
    add_index :areas, :ancestry
  end

  def self.down
    remove_index :areas, :ancestry
    remove_column :areas, :ancestry
  end
end
