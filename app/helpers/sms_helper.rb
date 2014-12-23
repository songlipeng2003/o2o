module SmsHelper
  def send_auth_code_sms(phone, code)
    tpl_params = { code: code, company: '微街电子商务公司' }
    ChinaSMS.to phone, tpl_params, tpl_id: 1
  end
end
