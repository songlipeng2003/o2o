module V1
  class SystemMonthCards < Grape::API

    resource :system_month_cards do
      desc "系统消费卡列表",
        http_codes: [
         [200, '成功', V1::Entities::SystemMonthCard]
        ]
      get do
        present SystemMonthCard.all, with: V1::Entities::SystemMonthCard
      end
    end
  end
end
