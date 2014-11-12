class CarModel < ActiveRecord::Base
    validates :name, presence: true
    validates :car_brand_id, presence: true

    belongs_to :car_brand
end
