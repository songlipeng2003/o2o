module V1
  class SystemMonthCards < Grape::API

    resource :system_month_cards do
      desc "系统消费卡列表",
        is_array: true,
        entity: V1::Entities::SystemMonthCard
      get do
        present SystemMonthCard.all, with: V1::Entities::SystemMonthCard
      end
    end
  end
end
