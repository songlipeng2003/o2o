class SMSWorker
  include Sidekiq::Worker

  def perform(phone, tpl_id, params)
    result = ChinaSMS.to phone, params, tpl_id: tpl_id
    if result['code']!=0
      logger.error result
    end
  end
end
