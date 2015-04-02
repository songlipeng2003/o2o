ActiveAdmin.register Car do
  menu parent: '汽车'

  index do
    selectable_column
    id_column
    column :user
    column :car_model
    column :license_tag
    column :color
    column :application
    column :created_at
    column :updated_at
    actions
  end

  filter :user_phone, as: :string
  filter :license_tag
  filter :color
  filter :car_model_name, as: :string
  filter :created_at
  filter :updated_at
end
