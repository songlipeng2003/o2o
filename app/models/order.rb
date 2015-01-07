class Order < ActiveRecord::Base
  belongs_to :user
  belongs_to :store
  belongs_to :car

  validates :user_id, presence: true
  validates :store_id, presence: true
  validates :car_id, presence: true
  validates :phone, presence: true
  validates :address, presence: true
  validates :lat, presence: true
  validates :lon, presence: true
  validates :book_at, presence: true
  validates :note, length: { maximum: 255 }

  validates_associated :user
  validates_associated :store
  validates_associated :car

  has_paper_trail
end
