class RenamePaymengLogToPaymentLogs < ActiveRecord::Migration
  def change
    rename_table :payment_log, :payment_logs
  end
end
