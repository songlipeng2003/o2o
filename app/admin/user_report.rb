ActiveAdmin.register_page "User Report" do
  menu parent: '统计', priority: 1, label: '用户统计'

  content title: '用户统计' do
    data = User.group(:application_id).count.map do |k, v|
      [Application.find(k).name, v]
    end

    pie_chart data
  end
end
