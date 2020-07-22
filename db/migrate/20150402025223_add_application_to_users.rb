class AddApplicationToUsers < ActiveRecord::Migration[4.2]
  def change
    change_table :users do |t|
      t.references :application
    end
  end
end
