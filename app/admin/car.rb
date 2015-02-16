ActiveAdmin.register Car do
  menu parent: '汽车'

  index do
    selectable_column
    id_column
    column :user
    column :car_model
    column :license_tag
    column :color
    actions
  end

  filter :license_tag
end
