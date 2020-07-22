class RenamePaymengLogToPaymentLogs < ActiveRecord::Migration[4.2]
  def change
    rename_table :payment_log, :payment_logs
  end
end
