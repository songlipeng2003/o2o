module Snable
  extend ActiveSupport::Concern

  included do
    before_create :gen_sn

    private
    def gen_sn
      sn = Time.now.strftime('%Y%m%d') + rand(100000...999999).to_s
      sn = gen_sn if Order.unscoped.where(sn: sn).first
      self.sn = sn
    end
  end

  module ClassMethods
  end

end
