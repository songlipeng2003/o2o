class CarStyle < ActiveRecord::Base
  belongs_to :car_brand
  belongs_to :car_model

  validates :name, presence: true, uniqueness: { scope: :car_model_id }

  has_paper_trail

  def car_model_id=(car_model_id)
    self[:car_model_id] = car_model_id
    if car_model
      self.car_brand_id = car_model.car_brand_id
    end
  end
end
