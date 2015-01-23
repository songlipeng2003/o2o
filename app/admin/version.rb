ActiveAdmin.register Version do
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
