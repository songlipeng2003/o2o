ActiveAdmin.register CarModel do
  menu parent: '汽车'

  belongs_to :car_brand
  permit_params :name, :car_brand_id, :first_letter, :auto_type

  index do
    selectable_column
    id_column
    column :name
    column :car_brand
    column :first_letter
    column :auto_type
    actions do |car_model|
      content = (link_to '车款管理', admin_car_model_car_styles_path(car_model))
      raw content
    end
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
