class LoginHistory < ActiveRecord::Base
  belongs_to :user, polymorphic: true
  belongs_to :application
end
