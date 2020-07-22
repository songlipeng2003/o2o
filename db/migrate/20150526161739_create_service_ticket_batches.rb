class CreateServiceTicketBatches < ActiveRecord::Migration[4.2]
  def change
    create_table :service_ticket_batches do |t|
      t.references :big_customer, index: true
      t.integer :number
      t.integer :used_count, default: 0

      t.timestamps
    end
  end
end
