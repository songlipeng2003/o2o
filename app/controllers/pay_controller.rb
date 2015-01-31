class PayController < ApplicationController
  def alipay_notify
    notify_params = params.except(*request.path_parameters.keys)

    if Alipay::Notify::App.verify?(notify_params)
      out_trade_no = params[:out_trade_no]
      @order = Order.find out_trade_no
      if ['TRADE_SUCCESS', 'TRADE_FINISHED'].include?(params[:trade_status])
        trade_no = params[:trade_no]
        @order.pay
      else params[:trade_status] == 'TRADE_CLOSED'
        @order.close
      end
      render :text => 'success'
    else
      render :text => 'error'
    end
  end
end
