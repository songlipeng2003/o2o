class RemovePingxxToPaymentLogs < ActiveRecord::Migration[6.0]
  def change
    change_table :payment_logs do |t|
      t.remove :pingxx
    end
  end
end
