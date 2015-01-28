class SMSWorker
  include Sidekiq::Worker

  def perform(phone, tpl_id, params)
    ChinaSMS.to phone, params, tpl_id: 1
  end
end
