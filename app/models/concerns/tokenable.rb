module Tokenable
  extend ActiveSupport::Concern

  included do
    before_save :ensure_authentication_token

    def ensure_authentication_token
      self.authentication_token ||= generate_authentication_token
    end

    private
    def generate_authentication_token
      loop do
        token = Devise.friendly_token
        break token unless User.where(authentication_token: token).first
      end
    end
  end

  module ClassMethods
  end

end
