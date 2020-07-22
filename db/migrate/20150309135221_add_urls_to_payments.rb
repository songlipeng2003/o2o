class AddUrlsToPayments < ActiveRecord::Migration[4.2]
  def change
    change_table :payments do |t|
      t.string :payment_type
    end

    Payment.create(name: '支付宝Wap支付', code: 'alipay_wap', payment_type: 'alipay', pay_fee:0)

    payment = Payment.where(code: 'alipay').first
    payment.payment_type = 'alipay_app'
    payment.save

    payment = Payment.where(code: 'weixin').first
    payment.payment_type = 'weixin'
    payment.save

    payment = Payment.where(code: 'balance').first
    payment.payment_type = 'balance'
    payment.save

    Payment.where(code: 'offline').first.destroy
  end
end
