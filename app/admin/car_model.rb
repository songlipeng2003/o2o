ActiveAdmin.register CarModel do
  menu parent: '汽车'

  permit_params :name, :car_brand_id

  index do
    selectable_column
    id_column
    column :name
    column :car_brand
    column :first_letter
    column :auto_type
    actions
  end

  filter :name
  # filter :car_brand_id, :as => :select, :collection => CarBrand.all.map{|c| [c.name, c.id]}

  form do |f|
    f.inputs do
      f.input :name
      f.input :car_brand_id, :as => :select, :collection => CarBrand.all.map{|c| [c.name, c.id]}
      f.input :first_letter, :collection => ('A'..'Z')
      f.input :auto_type
    end
    f.actions
  end
end
