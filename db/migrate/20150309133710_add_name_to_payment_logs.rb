class AddNameToPaymentLogs < ActiveRecord::Migration
  def change
    change_table :payment_logs do |t|
      t.string :name
    end
  end
end
