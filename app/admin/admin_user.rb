ActiveAdmin.register AdminUser do
  menu parent: '用户'

  permit_params :email, :password, :password_confirmation, :province_id, :city_id, :area_id

  index do
    selectable_column
    id_column
    column :email
    column :current_sign_in_at
    column :sign_in_count
    column :created_at
    actions
  end

  filter :email
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at

  form :partial => "form"
end
