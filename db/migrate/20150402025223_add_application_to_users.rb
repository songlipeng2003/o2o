class AddApplicationToUsers < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.references :application
    end
  end
end
