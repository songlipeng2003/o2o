ActiveAdmin.register Doc do
  menu parent: '基础数据'

  permit_params :title, :key, :content

  index do
    selectable_column
    id_column
    column :title
    column :key
    column :created_at
    column :updated_at
    actions
  end

  filter :name

  form do |f|
    f.inputs do
      f.input :title
      f.input :key
      f.input :content, :as => :ckeditor
    end
    f.actions
  end
end
