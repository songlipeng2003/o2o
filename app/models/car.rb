class Car < ActiveRecord::Base
  validates :car_model_id, presence: true
  # validates :buy_date, presence: true
  validates :user_id, presence: true
  validates :license_tag, presence: true
  # validates :license_tag, format: { with: /\p{Han}{1}[A-Z]{1}[A-Z_0-9]{5}/u,
  #   message: '车牌号错误' }

  acts_as_paranoid

  has_paper_trail

  before_validation do
    self.license_tag = license_tag.upcase
  end

  belongs_to :user
  belongs_to :car_model
  belongs_to :car_style
  belongs_to :application

  def car_model_name
    self.car_model_id ? self.car_model.name : ''
  end

  def car_style_id=(car_style_id)
    self[:car_style_id] = car_style_id
    if car_style
      self.car_model_id = car_style.car_model_id
    end
  end
end
