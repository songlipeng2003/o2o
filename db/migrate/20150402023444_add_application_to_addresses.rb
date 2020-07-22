class AddApplicationToAddresses < ActiveRecord::Migration[4.2]
  def change
    change_table :addresses do |t|
      t.references :application
    end
  end
end
