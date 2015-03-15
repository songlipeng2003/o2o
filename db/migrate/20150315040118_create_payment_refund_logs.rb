class CreatePaymentRefundLogs < ActiveRecord::Migration
  def change
    create_table :payment_refund_logs do |t|
      t.string :sn
      t.references :payment, index: true
      t.references :payment_log, index: true
      t.float :amount
      t.string :state

      t.timestamps
    end
  end
end
