class AddApplicationToAddresses < ActiveRecord::Migration
  def change
    change_table :addresses do |t|
      t.references :application
    end
  end
end
