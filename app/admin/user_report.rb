ActiveAdmin.register_page "User Report" do
  menu parent: '统计', priority: 1, label: '用户统计'

  content title: '用户统计' do
    panel '注册来源统计' do
      pie_chart User.group(:application_id).count.map do |k, v|
        [Application.find(k).name, v]
      end
    end

    panel '每日注册量统计' do
      line_chart User.group_by_day(:created_at).count
    end

    panel '每周注册量统计' do
      line_chart User.group_by_week(:created_at).count
    end

    panel '每月注册量统计' do
      line_chart User.group_by_month(:created_at).count
    end
  end
end
