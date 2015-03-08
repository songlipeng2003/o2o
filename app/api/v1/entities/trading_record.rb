module V1
  module Entities
    class TradingRecord < Grape::Entity
      expose :id
      expose :trading_type
      expose :trading_type_name
      expose :amount
      # expose :object
      expose :remark
      expose :created_at
    end
  end
end
