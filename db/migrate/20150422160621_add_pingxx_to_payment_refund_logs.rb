class AddPingxxToPaymentRefundLogs < ActiveRecord::Migration
  def change
    change_table :payment_refund_logs do |t|
      t.string :pingxx
    end
  end
end
