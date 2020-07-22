class AddOutTradeNoToPaymentRefundLogs < ActiveRecord::Migration[4.2]
  def change
    change_table :payment_refund_logs do |t|
      t.string :out_trade_no
    end
  end
end
