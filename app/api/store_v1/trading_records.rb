module StoreV1
  class TradingRecords < Grape::API
    before do
      error!("401 Unauthorized", 401) unless authenticated
    end

    resource :trading_records do
      desc "交易记录",
        headers: {
          "X-Access-Token" => {
            description: "Token",
            required: true
          },
        },
        http_codes: [
         [200, '成功', StoreV1::Entities::TradingRecord]
        ]
      paginate per_page: 10
      get do
        trading_records = paginate current_store.trading_records.order('id DESC')
        present trading_records, with: StoreV1::Entities::TradingRecord
      end
    end
  end
end
