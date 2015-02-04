ActiveAdmin.register_page "Queue" do
  menu label: '队列', parent: '系统'

  content :title => proc{ I18n.t("active_admin.dashboard") } do
    iframe :src => '/sidekiq', :style => 'width:100%; height:600px'
  end
end
