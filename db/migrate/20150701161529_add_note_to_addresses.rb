class AddNoteToAddresses < ActiveRecord::Migration
  def change
    change_table :addresses do |t|
      t.string :note
    end
  end
end
