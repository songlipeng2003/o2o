class BigCustomer < ActiveRecord::Base
  include Financeable

  belongs_to :province, class_name: 'Area'
  belongs_to :city, class_name: 'Area'
  belongs_to :area, class_name: 'Area'

  validates :name, presence: true
  validates :contacts, presence: true
  validates :phone, presence: true
  validates :province, presence: true
  validates :city, presence: true
  validates :area, presence: true
end
