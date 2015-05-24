class SystemMonthCard < ActiveRecord::Base
  belongs_to :province, class_name: 'Area'
  belongs_to :city, class_name: 'Area'

  validates :name, presence: true
  validates :month, presence: true, :numericality => { :only_integer => true, greater_than: 0 }
  validates :price, presence: true, :numericality => { :only_integer => true, greater_than: 0 }
  validates :province, presence: true
  validates :city, presence: true

  default_scope -> { order('sort DESC, id DESC') }
end
