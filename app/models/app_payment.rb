class AppPayment < ActiveRecord::Base
  belongs_to :application
  belongs_to :payment

  validates :sort, presence: true, :numericality => { :only_integer => true, greater_than_or_equal_to: 0 }

  default_scope -> { order('sort DESC, id DESC') }
end
