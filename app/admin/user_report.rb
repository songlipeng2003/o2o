ActiveAdmin.register_page "User Report" do
  menu parent: '统计', priority: 1, label: '用户统计'

  content title: '用户统计' do
    pie_chart Order.group(:application_id).count
  end
end
