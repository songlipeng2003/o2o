class CreatePayments < ActiveRecord::Migration[4.2]
  def change
    create_table :payments do |t|
      t.string :name
      t.string :description
      t.string :code
      t.float :pay_fee

      t.timestamps
    end

    change_table :orders do |t|
      t.references :payment
    end

    change_table :recharges do |t|
      t.references :payment
    end

    create_table :payment_log do |t|
      t.references :item, polymorphic: true
      t.references :payment
      t.string :state

      t.timestamps
    end

    Payment.create name: '余额支付', code: 'balance', pay_fee: 0
    Payment.create name: '支付宝', code: 'alipay', pay_fee: 0
    Payment.create name: '微信支付', code: 'weixin', pay_fee: 0
  end
end
