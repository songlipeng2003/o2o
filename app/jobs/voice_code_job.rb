require "uri"
require "net/http"

class VoiceCodeJob < ApplicationJob
  queue_as :default

  def perform(phone, code)
    params = {
      apikey: Settings.yunpian.password,
      mobile: phone,
      code: code
    }

    reponse = Net::HTTP.post_form(URI.parse('http://voice.yunpian.com/v1/voice/send.json'), params)
    data = JSON.parse(reponse.body)
    if data['code']!=0
      logger.error(data['msg'])
    end
  end
end
