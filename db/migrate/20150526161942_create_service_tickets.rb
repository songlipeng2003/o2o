class CreateServiceTickets < ActiveRecord::Migration
  def change
    create_table :service_tickets do |t|
      t.references :big_customer, index: true
      t.references :user, index: true
      t.references :service_ticket_batch, index: true
      t.string :code
      t.string :state

      t.timestamps
    end
  end
end
