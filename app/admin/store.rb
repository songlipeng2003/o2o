ActiveAdmin.register Store do
  permit_params :name, :address, :phone, :description, :lon, :lat, :service_area, :area_id, :province_id, :city_id

  index do
    selectable_column
    id_column
    column :name
    column :address
    column :phone
    actions defaults: true do |store|
      link_to '用户管理', admin_store_store_users_path(store)
    end
  end

  filter :name
  filter :address
  filter :phone

  form :partial => "form"
end
