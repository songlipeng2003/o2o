class CarModel < ActiveRecord::Base
  validates :name, presence: true
  validates :car_brand_id, presence: true
  validates :name, uniqueness: { scope: :car_brand_id }
  validates :first_letter, presence: true
  validates :auto_type, presence: true

  belongs_to :car_brand
  has_many :car_styles

  acts_as_paranoid
end
