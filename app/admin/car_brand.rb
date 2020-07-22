ActiveAdmin.register CarBrand do
  menu parent: '汽车'

  permit_params :name, :first_letter

  index do
    selectable_column
    id_column
    column :name
    column :first_letter
    actions do |car_brand|
      content = ' '
      content << (link_to '车型管理', admin_car_brand_car_models_path(car_brand))
      raw content
    end
  end

  filter :name

  form do |f|
    f.inputs do
      f.input :name
      f.input :first_letter, :collection => ('A'..'Z')
    end
    f.actions
  end

  action_item :import, :only => :index do
    link_to('导入', import_admin_car_brands_path, method: :post)
  end

  collection_action :import, :method => :post do
    CarBrand.import

    redirect_to action: :index, :notice => "导入成功"
  end
end
