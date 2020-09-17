class RemovePingxxToPaymentRefundLogs < ActiveRecord::Migration[6.0]
  def change
    change_table :payment_refund_logs do |t|
      t.remove :pingxx
    end
  end
end
