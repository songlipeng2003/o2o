require 'JPush'

class Announcement < ActiveRecord::Base
  include UmengPush

  validates :title, presence: true
  validates :content, presence: true

  after_create do
    client = JPush::JPushClient.new(Settings.jpush.app_key, Settings.jpush.master_secret)
    payload = JPush::PushPayload.new(
      platform: JPush::Platform.all,
      audience: JPush::Audience.all,
      notification: JPush::Notification.new(alert: self.title)
    )
    begin
     result = client.sendPush(payload)
    rescue JPush::ApiConnectionException => e
      logger.error(e)
    end

    logger.debug("jpush result  " + result)
  end

  def self.count_of(last_time)
    self.where("created_at>?", Time.at(last_time)).count()
  end
end
