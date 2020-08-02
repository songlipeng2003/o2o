class PayController < ApplicationController
  skip_before_action :verify_authenticity_token

  def alipay_app_notify
    notify_params = params.except(*request.path_parameters.keys)

    if Alipay::Notify::App.verify?(notify_params)
      out_trade_no = params[:out_trade_no]
      trade_no = params[:trade_no]
      trade_status = params[:trade_status]

      @payment_log = PaymentLog.where(sn: out_trade_no).first
      @payment_log.notify_params = params.to_json

      notify_log = NotifyLog.new
      notify_log.payment = @payment_log.payment
      notify_log.type = 'pay'
      notify_log.params = params.to_json
      notify_log.save

      if ['TRADE_SUCCESS', 'TRADE_FINISHED'].include?(trade_status)
        if @payment_log.unpayed?
          @payment_log.pay
          @payment_log.out_trade_no = trade_no
          @payment_log.save
        end
      elsif trade_status == 'TRADE_CLOSED'
        if @payment_log.unpayed?
          @payment_log.close
          @payment_log.save
        end
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

      @payment_log = PaymentLog.where(sn: out_trade_no).first
      @payment_log.notify_params = params.to_json

      notify_log = NotifyLog.new
      notify_log.payment = @payment_log.payment
      notify_log.type = 'pay'
      notify_log.params = params.to_json
      notify_log.save

      if ['TRADE_SUCCESS', 'TRADE_FINISHED'].include?(trade_status)
        @payment_log.pay
        @payment_log.out_trade_no = trade_no
        @payment_log.save
      elsif trade_status == 'TRADE_CLOSED'
        @payment_log.close
        @payment_log.save
      end

      render :text => 'success'
    else
      render :text => 'error'
    end
  end

  def alipay_refund_notify
    notify_params = params.except(*request.path_parameters.keys)
    if Alipay::Notify.verify?(notify_params)
      RefundBatch.transaction do
        refund_batch = RefundBatch.where(sn: params[:batch_no]).first
        refund_batch.finish! if params['success_num'].to_i == refund_batch.payment_refund_logs.size
        params['result_details'].split('#').each do |item|
          # 交易号^退款金额^处理结果$退费账号^退费账户 ID^退费金额^处理结果
          # 2010031906272929^80^SUCCESS$jax_chuanhang@alipay.com^2088101003147483^0.01^SUCCESS
          trade_no, amount, result = item.split(/\^|\$/)
          if result.downcase == 'success'
            payment_refund_log = PaymentRefundLog.where(out_trade_no: trade_no).first
            payment_refund_log.finish!
          end
        end
      end
      render text: 'success'
    else
      render text: 'fail'
    end
  end

  def pingxx_notify
    text = 'fail'
    begin
      if params[:object].nil?
      elsif params[:object] == 'charge'
        @payment_log = PaymentLog.where(sn: params[:order_no]).first
        if @payment_log.unpayed?
          @payment_log.notify_params = params.to_json
          @payment_log.pingxx = params[:id]
          @payment_log.pay
          @payment_log.out_trade_no = params[:transaction_no]
          @payment_log.save

          notify_log = NotifyLog.new
          notify_log.payment = @payment_log.payment
          notify_log.type = 'pay'
          notify_log.params = params.to_json
          notify_log.save
        end

        text = 'success'
        # 开发者在此处加入对支付异步通知的处理代码
      elsif params[:object] == 'refund'
        payment_refund_log = PaymentRefundLog.where(pingxx: params[:id]).first
        if payment_refund_log.applyed?
          payment_refund_log.finish!
        end

        text = 'success'
        # 开发者在此处加入对退款异步通知的处理代码
      end
    rescue JSON::ParserError
      text = 'fail'
    end

    render text: text
  end

  def cmbc
    @pay_url = Settings.cmbc.pay_url
    @order_info = params[:order_info]

    render layout: false
  end

  def cmbc_notify
    payresult = params[:payresult]

    url = Settings.cmbc.sign_encrypt_url
    uri = URI.parse(url)

    http = Net::HTTP.new(uri.host, uri.port)
    request = Net::HTTP::Get.new(uri.request_uri)

    response = http.request(request)

    if response.code == "200"
      str = response.body
    end

    arr = str.split('|')
  end
end
