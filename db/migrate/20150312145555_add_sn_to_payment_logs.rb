class AddSnToPaymentLogs < ActiveRecord::Migration
  def change
    change_table :payment_logs do |t|
      t.string :sn, after: :id
    end
  end
end
