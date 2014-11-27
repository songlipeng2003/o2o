ActiveAdmin.register Community do
  permit_params :name, :address, :area_id


  index do
    selectable_column
    id_column
    column :name
    column :address
    column :area
    actions
  end

  filter :name

  form do |f|
    f.inputs do
      f.input :name
      f.input :address
      f.input :area_id, :as => :select, :collection => Area.all.map{|c| [c.name, c.id]}
    end
    f.actions
  end
end
