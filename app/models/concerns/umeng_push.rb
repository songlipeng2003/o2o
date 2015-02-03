require 'digest'
require 'json'
require 'net/http'

module UmengPush
  extend ActiveSupport::Concern

  included do

  end

  module ClassMethods
    PUSH_URL = 'http://msg.umeng.com/api/send'

    # 单播
    PUSH_TYPE_UNICAST = 'unicast'
    # 列播
    PUSH_TYPE_LISTCAST = 'listcast'
    # 广播
    PUSH_TYPE_BROADCAST = 'broadcast'
    # 组播
    PUSH_TYPE_GROUPCAST = 'groupcast'

    def umeng_broadcast_push(options = {})
      applications = Application.all()
      applications.each do |application|
        if application.type==Application::APP_TYPE_IOS
          params = umeng_ios_broadcast(options)
        elsif application.type==Application::APP_TYPE_ANDROID
          params = umeng_android_broadcast(options)
        end

        umeng_push(params, application.app_key, application.app_master_secret)
      end
    end

    def umeng_android_broadcast(options = {})
      params = android_broadcast(options)

      push(params)
    end

    def umeng_ios_broadcast(options = {})
      params = ios_broadcast(options)

      push(params)
    end

    def umeng_android_params(options = {})
      params ={
        appkey: options[:appkey],
        timestamp: Time.now.to_i,
        type: options[:type],
        payload: {
          display_type: options[:display_type],
          body: {
            ticker: options[:ticker],
            title: options[:title],
            text: options[:text],
          }
        }
      }
    end

    def umeng_ios_params(options = {})
      params = {
        appkey: options[:appkey],
        timestamp: Time.now.to_i,
        type: options[:type],
        payload: {
          aps: {
            alert: options[:alert]
          }
        }
      }
    end

    def umeng_push(params, app_key, app_master_secret)
      method = 'POST'
      sign =  Digest::MD5.hexdigest(method+self::PUSH_URL+JSON.encode(params)+app_key+app_master_secret)

      url = self::PUSH_URL << '?sign=#{sign}'
      uri = URI(url)
      http = Net::HTTP.new(uri.host, uri.port)
      req = Net::HTTP::POST.new(uri.path, initheader = {'Content-Type' =>'application/json'})
      req.body = params.to_json
      res = http.request(req)
      result = JSON.parse(res.body)
      if(result['ret']=='SUCCESS')
        logger.debug("友盟推送成功")
      else
        logger.error("友盟推送错误");
        logger.error(result);
      end
    end
  end

end
