module V1
  class AuthCodes < Grape::API
    resource :auth_code do
      desc '发送短信验证码'
      params do
        requires :phone, type: String, desc: "手机号"
      end
      post do
        phone = params[:phone]
        code = AuthCode.generate phone
        tpl_params = { code: code, company: '嘀嘀去哪儿' }
        ChinaSMS.to phone, tpl_params, tpl_id: 1
      end
    end
  end
end
