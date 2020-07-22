class AddSubsidyTradingRecord < ActiveRecord::Migration[4.2]
  def change
    Recharge.where(state: 'payed').all.each do |recharge|
      if !recharge.present_amount.blank? && recharge.present_amount > 0
        trading_record = TradingRecord.new
        trading_record.user = SystemUser.company
        trading_record.trading_type = TradingRecord::TRADING_TYPE_SUBSIDY
        trading_record.object = recharge
        trading_record.name = "充值#{recharge.amount}元补贴#{recharge.present_amount}元"
        trading_record.amount = -recharge.present_amount
        trading_record.save
      end
    end
  end
end
