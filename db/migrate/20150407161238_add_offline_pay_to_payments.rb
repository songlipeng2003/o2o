class AddOfflinePayToPayments < ActiveRecord::Migration
  def up
    Payment.create(name: '线下支付', code: 'offline', payment_type: 'offline', pay_fee: 0)
  end

  def down
    Payment.find_by(code: 'offline').destroy
  end
end
