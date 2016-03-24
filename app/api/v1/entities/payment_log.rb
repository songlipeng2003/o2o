require 'openssl'
require 'base64'

module V1
  module Entities
    class PaymentLog < Grape::Entity
      expose :id, documentation: { type: Integer, desc: '编号' }
      expose :name, documentation: { type: String, desc: '名称' }
      expose :sn, documentation: { type: String, desc: "交易流水号" }
      expose :amount, documentation: { type: Float, desc: "支付金额" }
      expose :state, documentation: { type: String, desc: "状态" }
      expose :state_text, documentation: { type: String, desc: "状态名称" } do |payment_log|
        payment_log.aasm.human_state
      end
      expose :created_at, documentation: { type: Time, desc: "创建时间" }
      expose :redirect_url, documentation: { type: String, desc: "支付跳转URL" } do |payment_log|
        if payment_log.payment.code == 'alipay_wap'
          options = {
            :req_data => {
              :out_trade_no  => payment_log.sn,
              :subject       => payment_log.name,
              :total_fee     => payment_log.amount,
              # :total_fee     => 0.01,
              :notify_url    => 'http://24didi.com/pay/alipay_wap_notify',
              :call_back_url => 'http://m.24didi.com' # TODO 跳转URL
            }
          }

          token = Alipay::Service::Wap.trade_create_direct_token(options)
          Alipay::Service::Wap.auth_and_execute(request_token: token)
        end

        if payment_log.payment.code == 'cmbc'
          now = Time.now
          date = now.strftime('%Y%m%d')
          time = now.strftime('%H%M%S')
          cmbc_id = Settings.cmbc.id
          cmbc_name = Settings.cmbc.name
          cmbc2_id = Settings.cmbc.id2
          notify_url = 'http:://24didi.com/pay/cmbc_notify'
          jump_url = 'http:://24didi.com/pay/cmbc_notify'

          # 订单号|交易金额|币种|交易日期|交易时间|商户代码|商户名称|备注1|备注2|是否实时返回标志|处理结果返回的URL|MAC|银行编码|产品编码
          str = "#{payment_log.sn}|#{payment_log.amount}|01|#{date}|#{time}|#{cmbc_id}|#{cmbc_name}|||0|#{notify_url}|||"

          puts str

          str = URI.encode(str)

          url = Settings.cmbc.sign_encrypt_url + "?msg=#{str}"
          uri = URI.parse(url)

          http = Net::HTTP.new(uri.host, uri.port)
          req = Net::HTTP::Post.new(uri.request_uri)

          resp = http.request(req)

          # if response.code == "200"
            order_info = resp.body
          # end

          "http://24didi.com/pay/cmbc?order_info=#{order_info}"
        end
      end
      expose :pay_params, documentation: { type: String, desc: "支付参数" } do |payment_log|
        if payment_log.payment.code == 'alipay_app'
          params = {}
          params['partner'] = Alipay.pid
          params['seller_id'] = Alipay.seller_email
          params['out_trade_no'] = payment_log.sn
          params['subject'] = payment_log.name
          params['body'] = payment_log.name
          params['total_fee'] = payment_log.amount
          # params['total_fee'] = 0.01
          params['notify_url'] = 'http://24didi.com/pay/alipay_app_notify'
          params['service'] = 'mobile.securitypay.pay'
          params['payment_type'] = 1
          params['_input_charset'] = 'utf-8'
          params['it_b_pay'] = '30m'
          # params['paymethod'] = 'expressGateway'
          # params['return_url'] = 'm.alipay.com'

          params = Alipay::Utils.stringify_keys(params)

          to_sign = params.map { |item| "#{item[0]}=\"#{item[1]}\"" }.join('&')

          keypair = OpenSSL::PKey::RSA.new File.read Rails.root.join( 'config', 'rsa_private_key.pem')
          signature = keypair.sign('sha1', to_sign.force_encoding("utf-8"))
          signature = Base64.strict_encode64(signature)
          signature = CGI.escape(signature)

          "#{to_sign}&sign=\"#{signature}\"&sign_type=\"RSA\""
        elsif payment_log.payment.code == 'weixin'
          Pingpp::Charge.create(
            :order_no  => payment_log.sn,
            :app       => { :id => "app_izrXHGyTKezTfjrz" },
            :channel   => 'wx_pub',
            :amount    => payment_log.amount*100,
            :client_ip => "127.0.0.1",
            :currency  => "cny",
            :subject   => payment_log.name,
            :body      => payment_log.name,
            :extra     => {
              open_id: payment_log.extras[:open_id]
            }
          )
        elsif payment_log.payment.code == 'weixin_app'
          Pingpp::Charge.create(
            :order_no  => payment_log.sn,
            :app       => { :id => "app_izrXHGyTKezTfjrz" },
            :channel   => 'wx',
            :amount    => payment_log.amount*100,
            :client_ip => "127.0.0.1",
            :currency  => "cny",
            :subject   => payment_log.name,
            :body      => payment_log.name,
          )
        end
      end
    end
  end
end
