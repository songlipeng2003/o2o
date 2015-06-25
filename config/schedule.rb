every 1.minute do
  runner "Order.auto_close_expired_order"
end

every 1.minute do
  runner "Recharge.auto_close_expired_recharge"
end

every 1.minute do
  runner "MonthCardOrder.auto_close_expired_order"
end

every 1.minute do
  runner "MonthCard.auto_expired"
end

every '1 0 * * *' do
  runner 'RefundBatch.auto_close_expired'
end
