module V1
  class AuthCodes < Grape::API
    resource :auth_codes do
      desc '发送短信验证码', {
        notes: <<-NOTE
          * 每个手机号每分钟只能发送一次验证码，重复发送返回失败
          * 验证码有效期为10分钟
          * 如果验证码没有被验证，重发验证码相同
        NOTE
      }
      params do
        requires :phone, type: String, desc: "手机号"
      end
      post do
        phone = params[:phone]
        code = AuthCode.generate phone
        tpl_params = { code: code, company: '嘀嘀去哪儿' }
        result = ChinaSMS.to phone, tpl_params, tpl_id: 1

        if result['code'] == 0
          {
            code: true,
            msg: '发送成功'
          }
        else
          {
            code: 1,
            msg: result['msg']
          }
        end
      end
    end
  end
end
