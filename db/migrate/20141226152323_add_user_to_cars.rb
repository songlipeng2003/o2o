class AddUserToCars < ActiveRecord::Migration
  def change
    change_table :cars do |t|
      t.references :user
    end
  end
end
