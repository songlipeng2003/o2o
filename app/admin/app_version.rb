ActiveAdmin.register AppVersion do
  menu parent: '系统'

  permit_params :file, :version, :description

  index do
    selectable_column
    id_column
    column :file, sortable: false do |app|
      if app.file.attached?
        link_to '下载文件', app.file, target: '_blank'
      end
    end
    column :version
    actions
  end

  filter :version
  filter :description

  form do |f|
    f.inputs do
      f.input :file, as: :file
      f.input :version
      f.input :description
    end
    f.actions
  end
end
