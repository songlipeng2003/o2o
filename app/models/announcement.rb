class Announcement < ActiveRecord::Base
  include UmengPush

  validates :title, presence: true
  validates :content, presence: true

  after_create do
    self.delay.push
  end

  def self.count_of(last_time)
    self.where("created_at>?", Time.at(last_time)).count()
  end

  def push
    client = JPush::JPushClient.new(Settings.jpush.app_key, Settings.jpush.master_secret)
    payload = JPush::PushPayload.new(
      platform: JPush::Platform.all,
      audience: JPush::Audience.all,
      notification: JPush::Notification.new(alert: self.title)
    )
    begin
      result = client.sendPush(payload)
      logger.debug("jpush result  " + result)
    rescue JPush::ApiConnectionException => e
      logger.error(e)
    end
  end
end
