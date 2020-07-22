class AddNameToPaymentLogs < ActiveRecord::Migration[4.2]
  def change
    change_table :payment_logs do |t|
      t.string :name
    end
  end
end
