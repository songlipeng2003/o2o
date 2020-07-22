module V1
  class TradingRecords < Grape::API
    before do
      error!("401 Unauthorized", 401) unless authenticated
    end

    resource :trading_records do
      desc "交易记录",
        is_array: true,
        entity: V1::Entities::TradingRecord
      paginate per_page: 10
      params do
        optional 'X-Access-Token', type: String, desc: 'Token', documentation: { in: :header }
      end
      get do
        trading_records = paginate current_user.trading_records.order('id DESC')
        present trading_records, with: V1::Entities::TradingRecord
      end
    end
  end
end
