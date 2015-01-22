ActiveAdmin.register Store do
  permit_params :name, :address, :phone, :description, :lon, :lat, :service_area, :area_id, :province_id, :city_id

  index do
    selectable_column
    id_column
    column :name
    column :address
    column :phone
    actions
  end

  filter :name
  filter :address
  filter :phone

  form :partial => "form"
end
