class Order < ActiveRecord::Base
  include AASM

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

  aasm column: :state do
    state :unpayed, :initial => true
    state :payed
    state :finished
    state :closed

    event :pay do
      transitions :from => :unpayed, :to => :payed
    end

    event :close do
      transitions :from => :unpayed, :to => :closed
    end

    event :finish do
      transitions :from => :payed, :to => :finished
    end
  end
end
