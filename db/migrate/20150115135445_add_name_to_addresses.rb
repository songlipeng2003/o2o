class AddNameToAddresses < ActiveRecord::Migration
  def change
    change_table :addresses do |t|
      t.string :name
    end
  end
end
