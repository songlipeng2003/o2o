class AddDepthToArea < ActiveRecord::Migration
  def change
    change_table :areas do |t|
      t.integer :ancestry_depth, :default => 0
    end
  end
end
