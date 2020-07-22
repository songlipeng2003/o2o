ActiveAdmin.register CarStyle do
  menu parent: '汽车'

  belongs_to :car_model

  permit_params :name, :car_brand_id

  index do
    selectable_column
    id_column
    column :name
    column :car_model
    column :car_brand
    actions
  end

  filter :name

  form do |f|
    f.inputs do
      f.input :name
    end
    f.actions
  end
end
