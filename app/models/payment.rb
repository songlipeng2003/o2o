class Payment < ActiveRecord::Base
  validates :name, presence: true, uniqueness: true
  validates :code, presence: true, uniqueness: true
  validates :pay_fee, presence: true, numericality: { greater_than_or_equal_to: 0 }

  has_many :app_payments, dependent: :destroy
  has_many :applications, through: :app_payments

  accepts_nested_attributes_for :app_payments, reject_if: :all_blank, allow_destroy: true
end
