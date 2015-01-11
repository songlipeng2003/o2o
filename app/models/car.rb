class Car < ActiveRecord::Base
  validates :car_model_id, presence: true
  validates :buy_date, presence: true
  validates :user_id, presence: true
  validates :license_tag, presence: true, uniqueness: { scope: :user_id }

  belongs_to :user
  belongs_to :car_model
end
