class AddUmengToUsers < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.string :umeng
    end
  end
end
