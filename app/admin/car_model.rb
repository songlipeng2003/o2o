ActiveAdmin.register CarModel do
  permit_params :name, :car_brand_id

  index do
    selectable_column
    id_column
    column :name
    column :car_brand
    actions
  end

  filter :name
  filter :car_brand_id, :as => :select, :collection => CarBrand.all.map{|c| [c.name, c.id]}

  form do |f|
    f.inputs do
      f.input :name
      f.input :car_brand_id, :as => :select, :collection => CarBrand.all.map{|c| [c.name, c.id]}
    end
    f.actions
  end
end
