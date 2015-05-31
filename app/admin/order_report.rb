ActiveAdmin.register_page "Order Report" do
  menu parent: '统计', priority: 1, label: '订单统计'

  content title: '订单统计' do
    pie_chart Order.group(:application_id).count
  end
end
