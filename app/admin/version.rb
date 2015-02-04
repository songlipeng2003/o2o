ActiveAdmin.register Version do
  menu parent: '系统'

  actions :index, :show

  index do
    selectable_column
    id_column
    column :item
    column :event
    column :whodunnit
    column :created_at
    actions
  end
end
