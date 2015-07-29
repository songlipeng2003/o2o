class AddPingxxToPaymentLogs < ActiveRecord::Migration
  def change
    change_table :payment_logs do |t|
      t.string :pingxx
    end
  end
end
