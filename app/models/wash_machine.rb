class WashMachine < ActiveRecord::Base
  belongs_to :province, class_name: 'Area'
  belongs_to :city, class_name: 'Area'
  belongs_to :area

  has_many :evaluations
  has_many :orders

  validates :code, presence: true, uniqueness: true
  validates :lat, presence: true
  validates :lon, presence: true
  validates :address, presence: true
  validates :province, presence: true
  validates :city, presence: true
  validates :area, presence: true
  validates :price, :numericality => { :only_integer => true, greater_than: 0 }, allow_blank: true

  validates_associated :province
  validates_associated :city
  validates_associated :area

  def name
    "#{id}号自助洗车机"
  end
end
