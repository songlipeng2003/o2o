class AddBookedEndAt < ActiveRecord::Migration[4.2]
  def change
    change_table :orders do |t|
      t.datetime :booked_end_at
    end

    Order.with_deleted.all.find_each do |order|
      order.booked_end_at = order.booked_at + 1.hours
      order.save
    end
  end
end
