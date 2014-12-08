class CarModel < ActiveRecord::Base
    validates :name, presence: true
    validates :car_brand_id, presence: true
    validates :name, uniqueness: { scope: :car_brand_id }

    belongs_to :car_brand
end
