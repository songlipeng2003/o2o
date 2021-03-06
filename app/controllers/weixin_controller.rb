class WeixinController < ApplicationController
  def auth
    code = params[:code]
    if code
      url = "https://api.weixin.qq.com/sns/oauth2/access_token?appid=wx0babbb28a049562d&secret=9b49714550a5e2bfc906a691ea463fab&code=#{code}&grant_type=authorization_code"
      uri = URI.parse(url)
      response = Net::HTTP.get_response(uri)

      result = JSON.parse response.body
      open_id = result['openid']
      if params[:development].blank?
        redirect_url = "http://m.24didi.com?open_id=#{open_id}"
      elsif
        redirect_url = "http://weixin.24didi.com?open_id=#{open_id}"
      end

      redirect_to redirect_url
    else
      render text: '参数不足'
    end
  end
end
