class Feedback < ActiveRecord::Base
  belongs_to :user
  belongs_to :application

  validates :title, presence: true
  validates :feedback_type, presence: true
  validates :content, presence: true
end
