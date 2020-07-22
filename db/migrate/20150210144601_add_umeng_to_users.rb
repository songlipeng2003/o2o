class AddUmengToUsers < ActiveRecord::Migration[4.2]
  def change
    change_table :users do |t|
      t.string :umeng
    end
  end
end
