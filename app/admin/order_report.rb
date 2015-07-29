ActiveAdmin.register_page "Order Report" do
  menu parent: '统计', priority: 1, label: '订单统计'

  content title: '订单统计' do
    data = Order.group(:application_id).count.map do |k, v|
      [Application.find(k).name, v]
    end
    pie_chart data
  end
end
