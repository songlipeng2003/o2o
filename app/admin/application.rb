ActiveAdmin.register Application do
  menu parent: '基础数据'

  permit_params :name, :umeng_app_key, :app_type, :app_master_secret

  index do
    selectable_column
    id_column
    column :name
    column :app_type
    column :umeng_app_key
    actions
  end

  filter :name

  form do |f|
    f.inputs do
      f.input :name
      f.input :app_type, collection: Application::APPT_TYPES
      f.input :umeng_app_key
      f.input :app_master_secret
    end
    f.actions
  end

end
