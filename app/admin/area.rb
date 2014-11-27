ActiveAdmin.register Area do
  permit_params :name, :parent_id

  index do
    selectable_column
    id_column
    column :name
    actions
  end

  filter :name

  form do |f|
    f.inputs do
      f.input :name
      f.input :parent_id, :as => :select, :collection => Area.all.map{|c| [c.name, c.id]}
    end
    f.actions
  end
end
