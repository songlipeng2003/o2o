class AddOfflineToPayments < ActiveRecord::Migration
  def change
    Payment.create name: '线下支付', code: 'offline', pay_fee: 0
  end
end
