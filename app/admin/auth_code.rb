ActiveAdmin.register AuthCode do
  menu parent: '系统'

  actions :index

  index do
    selectable_column
    id_column
    column :phone
    column :code
    column :expired_at
    column :created_at
    column :updated_at
    actions
  end

  filter :phone
end
