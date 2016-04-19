module V1
  class MonthCards < Grape::API
    before do
      error!("401 Unauthorized", 401) unless authenticated
    end

    resource :month_cards do
      desc "消费卡记录", {
        is_array: true,
        entity: V1::Entities::MonthCard
      }
      paginate
      params do
        optional 'X-Access-Token', type: String, desc: 'Token', documentation: { in: :header }
      end
      get do
        month_cards =  paginate current_user.month_cards.order('id DESC')
        present month_cards, with: V1::Entities::MonthCard
      end

      desc '可用消费卡数量'
      params do
        optional 'X-Access-Token', type: String, desc: 'Token', documentation: { in: :header }
      end
      get :available_count do
        count = current_user.month_cards.available.count
        { count: count }
      end
    end
  end
end
