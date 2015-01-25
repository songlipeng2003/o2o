class AddUserToImages < ActiveRecord::Migration
  def change
    change_table :images do |t|
      t.references :user, index: true
    end
  end
end
