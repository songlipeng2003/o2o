class AddApplicationToPaymentLogs < ActiveRecord::Migration
  def change
    change_table :payment_logs do |t|
      t.references :application
    end
  end
end
