class CreateRefundBatches < ActiveRecord::Migration[4.2]
  def change
    create_table :refund_batches do |t|
      t.references :payment, index: true
      t.string :sn
      t.string :state

      t.timestamps
    end

    change_table :payment_refund_logs do |t|
      t.references :refund_batch
    end

    create_join_table :payment_refund_logs, :refund_batches
  end
end
