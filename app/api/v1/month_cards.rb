module V1
  class MonthCards < Grape::API
    before do
      error!("401 Unauthorized", 401) unless authenticated
    end

    resource :month_cards do
      desc "月卡记录", {
        headers: {
          "X-Access-Token" => {
            description: "Token",
            required: true
          },
        },
        http_codes: [
          [200, 'Ok', V1::Entities::MonthCard]
        ]
      }
      paginate
      get do
        month_cards =  paginate current_user.month_cards
        present month_cards, with: V1::Entities::MonthCard
      end
    end
  end
end