ActiveAdmin.register BannerGroup do
  menu parent: '系统'

  permit_params :key, :name

  index do
    selectable_column
    id_column
    column :key
    column :name
    actions
  end

  filter :key
  filter :name

  form do |f|
    f.inputs do
      f.input :key
      f.input :name
    end
    f.actions
  end
end
