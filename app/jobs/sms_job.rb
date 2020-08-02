class SmsJob < ApplicationJob
  queue_as :default

  def perform(phone, tpl_id, params)
    # Do something later
    result = ChinaSMS.to phone, params, tpl_id: tpl_id
    if result['code']!=0
      logger.error result
    end
  end
end
