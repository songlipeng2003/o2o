ActiveAdmin.register_page "Recharge Report" do
  menu parent: '统计', priority: 1, label: '充值统计'

  content title: '充值统计' do
    panel '来源统计' do
      pie_chart Recharge.group(:application_id).count.map do |k, v|
        [Application.find(k).name, v]
      end
    end

    panel '每日充值量统计' do
      line_chart Recharge.where(state: :payed).where('created_at>?', 1.years.ago).group_by_day(:created_at).count
    end

    panel '每日充值额统计' do
      line_chart Recharge.where(state: :payed).where('created_at>?', 1.years.ago).group_by_day(:created_at).sum(:amount)
    end

    panel '每周充值量统计' do
      line_chart Recharge.where(state: :payed).where('created_at>?', 1.years.ago).group_by_week(:created_at).count
    end

    panel '每周充值额统计' do
      line_chart Recharge.where(state: :payed).where('created_at>?', 1.years.ago).group_by_week(:created_at).sum(:amount)
    end

    panel '每月充值量统计' do
      line_chart Recharge.where(state: :payed).where('created_at>?', 1.years.ago).group_by_month(:created_at).count
    end

    panel '每月充值额统计' do
      line_chart Recharge.where(state: :payed).where('created_at>?', 1.years.ago).group_by_month(:created_at).sum(:amount)
    end
  end
end
