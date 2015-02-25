class PayController < ApplicationController
  def alipay_notify
    notify_params = params.except(*request.path_parameters.keys)

    if Alipay::Notify::App.verify?(notify_params)
      out_trade_no = params[:out_trade_no]
      trade_no = params[:trade_no]
      trade_status = params[:trade_status]

      if out_trade_no.start_with?('RECHARGE')
        @recharge = Recharge.find out_trade_no[8, out_trade_no.length]
        if ['TRADE_SUCCESS', 'TRADE_FINISHED'].include?(trade_status)
          @recharge.pay
        end
      else
        @order = Order.find out_trade_no
        if ['TRADE_SUCCESS', 'TRADE_FINISHED'].include?(trade_status)
          @order.pay
        else trade_status == 'TRADE_CLOSED'
          @order.close
        end
      end
      render :text => 'success'
    else
      render :text => 'error'
    end
  end
end
