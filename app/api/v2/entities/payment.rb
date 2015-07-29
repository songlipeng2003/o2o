module V1
  module Entities
    class Payment < Grape::Entity
      expose :id, documentation: { type: Integer, desc: '编号' }
      expose :name, documentation: { type: String, desc: '名称' }
      expose :code, documentation: { type: String, desc: '编号，balance余额支付、alipay支付宝、wexin微信支付' }
    end
  end
end
