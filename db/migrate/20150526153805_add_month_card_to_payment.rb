class AddMonthCardToPayment < ActiveRecord::Migration[4.2]
  def change
    Payment.create(
      name: '消费卡支付',
      code: 'month_card',
      payment_type: 'month_card',
      pay_fee: 0
    )
  end
end
