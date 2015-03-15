every 1.minute do
  runner "Order.auto_close_expired_order"
end

every 1.minute do
  runner "Recharge.auto_close_expired_recharge"
end
