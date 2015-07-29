ActiveAdmin.register_page "Recharge Report" do
  menu parent: '统计', priority: 1, label: '充值统计'

  content title: '充值统计' do
    data = Recharge.group(:application_id).count.map do |k, v|
      [Application.find(k).name, v]
    end
    pie_chart data
  end
end
