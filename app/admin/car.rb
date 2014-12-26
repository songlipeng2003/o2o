ActiveAdmin.register Car do
  menu parent: '汽车'
  actions :index, :show

  index do
    selectable_column
    id_column
    column :user
    column :car_model
    column :license_tag
    actions
  end

  filter :license_tag
end
