class AddLocationToCommunities < ActiveRecord::Migration
  def change
    change_table :communities do |t|
      t.float :lat
      t.float :lon
    end
  end
end
