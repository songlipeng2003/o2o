ActiveAdmin.register CarModel do
  permit_params :name, :car_brand_id

  index do
    selectable_column
    id_column
    column :name
    column :first_letter
    actions
  end

  filter :name

  form do |f|
    f.inputs do
      f.input :name
      f.input :car_brand_id, :collection => CarBrand.all.map{|c| [c.name, c.id]}
    end
    f.actions
  end
end
