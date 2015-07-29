namespace :order do
  desc "恢复第三方支付没有充值记录的问题"
  task close_unclosed_payment_log: :environment do
    Order.where(state: 'closed').each do |order|
      order.payment_logs.where(state: 'unpayed').each do |payment_log|
        payment_log.close!

        puts "关闭#{payment_log.sn}支付历史"
      end
    end
  end

end
