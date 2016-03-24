ActiveAdmin.register LoginHistory do
  menu parent: '用户'

  actions :index

  index do
    id_column
    column :user
    column :device
    column :device_type
    column :device_model
    column :ip
    column :application
    column :created_at
    actions
  end
end
