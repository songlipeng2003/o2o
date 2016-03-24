class AddServiceTicketToOrders < ActiveRecord::Migration
  def change
    change_table :orders do |t|
      t.references :service_ticket
    end

    change_table :service_tickets do |t|
      t.float :order_amount
    end
  end
end
