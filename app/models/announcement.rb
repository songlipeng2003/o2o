class Announcement < ActiveRecord::Base
  include UmengPush

  validates :title, presence: true
  validates :content, presence: true

  after_create do
    Announcement.delay.umeng_broadcast_push(
      ticker: self.title,
      title: self.title,
      text: self.content.truncate(30),
      alert: self.title
    )
  end

  def self.count_of(last_time)
    self.where("created_at>?", Time.at(last_time)).count()
  end
end
