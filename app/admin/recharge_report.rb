ActiveAdmin.register_page "Recharge Report" do
  menu parent: '统计', priority: 1, label: '充值统计'

  content title: '充值统计' do
    pie_chart Recharge.group(:application_id).count
  end
end
