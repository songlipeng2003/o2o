class AddAmountPaymentLogs < ActiveRecord::Migration
  def change
    change_table :payment_logs do |t|
      t.float :amount
    end
  end
end
