class AddCmbcPayment < ActiveRecord::Migration[4.2]
  def up
    payment = Payment.new
    payment.name = '民生银行'
    payment.description = ''
    payment.payment_type = 'cmbc'
    payment.code = 'cmbc'
    payment.pay_fee = 0
    payment.is_show = 1
    payment.save
  end

  def down
  end
end
