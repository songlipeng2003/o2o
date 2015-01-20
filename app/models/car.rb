class Car < ActiveRecord::Base
  validates :car_model_id, presence: true
  # validates :buy_date, presence: true
  validates :user_id, presence: true
  validates :license_tag, presence: true

  belongs_to :user
  belongs_to :car_model

  def car_model_name
    self.car_model.name
  end
end
