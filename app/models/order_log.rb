class OrderLog < ActiveRecord::Base
  belongs_to :order

  belongs_to :user, polymorphic: true
end
