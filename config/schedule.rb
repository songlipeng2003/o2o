every 1.minute do
  runner "Order.auto_close_expired_order"
end
