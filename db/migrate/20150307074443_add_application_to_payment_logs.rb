class AddApplicationToPaymentLogs < ActiveRecord::Migration[4.2]
  def change
    change_table :payment_logs do |t|
      t.references :application
    end
  end
end
