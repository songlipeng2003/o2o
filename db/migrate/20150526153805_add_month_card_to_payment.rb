class AddMonthCardToPayment < ActiveRecord::Migration
  def change
    Payment.create(
      name: '月卡支付',
      code: 'month_card',
      payment_type: 'month_card',
      pay_fee: 0
    )
  end
end
