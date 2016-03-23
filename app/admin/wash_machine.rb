ActiveAdmin.register WashMachine do
  menu parent: '基础数据'

  permit_params :code, :lat, :lon, :address, :province_id, :city_id, :area_id

  index do
    selectable_column
    id_column
    column :code
    column :address
    column :created_at
    column :updated_at
    actions
  end

  filter :code
  filter :address
  filter :created_at
  filter :updated_at

  form :partial => "form"
end
