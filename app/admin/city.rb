ActiveAdmin.register City do
  menu parent: '基础数据'

  permit_params :name

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
    end
    f.actions
  end
end
