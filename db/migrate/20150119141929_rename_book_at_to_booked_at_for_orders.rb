class RenameBookAtToBookedAtForOrders < ActiveRecord::Migration
  def change
    change_table :orders do |t|
      t.rename :book_at, :booked_at
    end
  end
end
