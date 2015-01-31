ActiveAdmin.register Application do
  permit_params :name, :umeng_app_key, :app_type

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
    end
    f.actions
  end

end
