class CarBrand < ActiveRecord::Base
    validates :name, presence: true, uniqueness: true
    validates :first_letter, presence: true
end
