namespace :recover do
  desc "恢复第三方支付没有充值记录的问题"
  task add_recharge_for_third_pay: :environment do
    TradingRecord.where(trading_type: TradingRecord::TRADING_TYPE_EXPENSE).each do |trading_record|
      if trading_record.object.payment_log.payment.code!='balance'
        recharge_trading_record = TradingRecord.where(
            trading_type: TradingRecord::TRADING_TYPE_RECHARGE,
            finance_id: trading_record.finance_id,
            object_id: trading_record.object_id,
            object_type: trading_record.object_type
          ).first

        unless recharge_trading_record
          recharge_trading_record = TradingRecord.new
          recharge_trading_record.finance = trading_record.finance
          recharge_trading_record.trading_type = TradingRecord::TRADING_TYPE_RECHARGE
          recharge_trading_record.object = trading_record.object
          recharge_trading_record.amount = trading_record.amount.abs
          recharge_trading_record.name = "充值#{recharge_trading_record.amount}"
          recharge_trading_record.save

          puts "为#{trading_record.id}生成充值流水"
        end
      end
    end
  end

end
