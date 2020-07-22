class AddAmountPaymentLogs < ActiveRecord::Migration[4.2]
  def change
    change_table :payment_logs do |t|
      t.float :amount
    end
  end
end
