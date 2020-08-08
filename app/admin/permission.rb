ActiveAdmin.register Permission do
  menu parent: '用户'

  permit_params :name, :subject_class, :subject_id, :action, :description

  index do
    id_column
    column :name
    column :action
    column :subject_class
    column :subject
    column :created_at
    column :updated_at
    actions
  end

  filter :name
  filter :subject_class
  filter :action

  form do |f|
    f.inputs do
      f.input :subject_class
      f.input :action
      f.input :subject_id
      f.input :name
      f.input :description
    end
    f.actions
  end

  action_item :import, :only => :index do
    link_to('导入', import_admin_permissions_path)
  end


  collection_action :import do
    Permission.import

    redirect_to action: :index, :notice => "导入成功"
  end
end
