class Announcement < ActiveRecord::Base
  validates :title, presence: true
  validates :content, presence: true

  def self.count_of(last_time)
    self.where("created_at>?", Time.at(last_time)).count()
  end
end
