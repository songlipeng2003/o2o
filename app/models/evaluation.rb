class Evaluation < ActiveRecord::Base
  belongs_to :order
  belongs_to :user
  belongs_to :store
  belongs_to :application
  belongs_to :store_user

  has_many :images, as: :item

  validates :order_id, presence: true
  validates :score, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0,
    less_than_or_equal_to: 5 }
  validates :note, length: { maximum: 255 }
  validates :user_id, presence: true

  # validates_associated :order
  validates_associated :user
  validates_associated :store

  before_validation do
    self.user_id = order.user_id
    self.store_id = order.store_id

    if !score
      self.score = (score1 + score2 + score3) / 3
    end
  end
end
