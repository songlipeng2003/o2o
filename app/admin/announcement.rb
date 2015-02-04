ActiveAdmin.register Announcement do
  menu parent: '系统'

  permit_params :title, :content

  index do
    selectable_column
    id_column
    column :title
    actions
  end

  filter :title
  filter :content

  form do |f|
    f.inputs do
      f.input :title
      f.input :content
    end
    f.actions
  end

end
