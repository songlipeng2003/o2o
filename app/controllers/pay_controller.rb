class PayController < ApplicationController
  def alipay_app_notify
    notify_params = params.except(*request.path_parameters.keys)

    if Alipay::Notify::App.verify?(notify_params)
      out_trade_no = params[:out_trade_no]
      trade_no = params[:trade_no]
      trade_status = params[:trade_status]

      @payment = Payment.find(out_trade_no)
      if ['TRADE_SUCCESS', 'TRADE_FINISHED'].include?(trade_status)
        @payment.pay
        @payment.out_trade_no = trade_no
        @payment.save
      else trade_status == 'TRADE_CLOSED'
        @payment.close
        @payment.save
      end

      render :text => 'success'
    else
      render :text => 'error'
    end
  end

  def alipay_wap_notify
    notify_params = params.except(*request.path_parameters.keys)

    if Alipay::Notify::Wap.verify?(notify_params)
      notify_data = Hash.from_xml(params[:notify_data])
      out_trade_no = notify_data['notify']['out_trade_no']
      trade_no = notify_data['notify']['trade_no']
      trade_status = notify_data['notify']['trade_status']

      @payment = Payment.find(out_trade_no)
      if ['TRADE_SUCCESS', 'TRADE_FINISHED'].include?(trade_status)
        @payment.pay
        @payment.out_trade_no = trade_no
        @payment.save
      else trade_status == 'TRADE_CLOSED'
        @payment.close
        @payment.save
      end

      render :text => 'success'
    else
      render :text => 'error'
    end
  end
end
