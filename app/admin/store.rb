ActiveAdmin.register Store do
  permit_params :name, :address, :phone, :description, :lon, :lat, :service_area

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

  # form do |f|
  #   f.inputs do
  #     f.input :name
  #     f.input :address
  #     f.input :phone
  #     f.input :description
  #     f.input :lon
  #     f.input :lat
  #   end
  #   f.actions
  # end
end
