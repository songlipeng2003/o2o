class Feedback < ActiveRecord::Base
  FEEDBACK_TYPE_FEEDBACK = 1
  FEEDBACK_TYPE_REPLY = 2

  FEEDBACK_TYPES = {
    FEEDBACK_TYPE_FEEDBACK => '反馈',
    FEEDBACK_TYPE_REPLY => '回复'
  }

  belongs_to :user
  belongs_to :application

  validates :feedback_type, presence: true
  validates :content, presence: true
end
