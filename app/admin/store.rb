ActiveAdmin.register Store do
  permit_params :name, :address, :phone, :description

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

  form do |f|
    f.inputs do
      f.input :name
      f.input :address
      f.input :phone
      f.input :description
    end
    f.actions
  end


end
