class AddServiceTicketToOrders < ActiveRecord::Migration[4.2]
  def change
    change_table :orders do |t|
      t.references :service_ticket
    end

    change_table :service_tickets do |t|
      t.float :order_amount
    end
  end
end
