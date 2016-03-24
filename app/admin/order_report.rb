ActiveAdmin.register_page "Order Report" do
  menu parent: '统计', priority: 1, label: '订单统计'

  content title: '订单统计' do
    panel '订单来源统计' do
      pie_chart Order.group(:application_id).count.map do |k, v|
        [Application.find(k).name, v]
      end
    end

    panel '每日订单量统计' do
      line_chart Order.where(state: [:payed, :confirmed, :finished]).where('created_at>?', 1.years.ago).group_by_day(:created_at).count
    end

    panel '每日订单额统计' do
      line_chart Order.where(state: [:payed, :confirmed, :finished]).where('created_at>?', 1.years.ago).group_by_day(:created_at).sum(:total_amount)
    end

    panel '每周订单量统计' do
      line_chart Order.where(state: [:payed, :confirmed, :finished]).where('created_at>?', 1.years.ago).group_by_week(:created_at).count
    end

    panel '每周订单额统计' do
      line_chart Order.where(state: [:payed, :confirmed, :finished]).where('created_at>?', 1.years.ago).group_by_week(:created_at).sum(:total_amount)
    end

    panel '每月订单量统计' do
      line_chart Order.where(state: [:payed, :confirmed, :finished]).where('created_at>?', 1.years.ago).group_by_month(:created_at).count
    end

    panel '每月订单额统计' do
      line_chart Order.where(state: [:payed, :confirmed, :finished]).where('created_at>?', 1.years.ago).group_by_month(:created_at).sum(:total_amount)
    end
  end
end
