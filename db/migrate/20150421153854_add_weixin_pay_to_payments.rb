class AddWeixinPayToPayments < ActiveRecord::Migration
  def up
    Payment.create(name: '微信App支付', code: 'weixin_app', payment_type: 'weixin', pay_fee: 0)
  end

  def down
    Payment.find_by(code: 'weixin_app').destroy
  end
end
