class AddClosedAtAndPayedAtToPaymentLog < ActiveRecord::Migration
  def change
    change_table :payment_log do |t|
      t.datetime :payed_at
      t.datetime :closed_at
      t.string :out_trade_no
      t.text :notify_params
    end
  end
end
