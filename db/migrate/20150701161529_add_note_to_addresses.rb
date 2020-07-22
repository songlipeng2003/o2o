class AddNoteToAddresses < ActiveRecord::Migration[4.2]
  def change
    change_table :addresses do |t|
      t.string :note
    end
  end
end
