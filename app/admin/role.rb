ActiveAdmin.register Role do
  menu parent: '用户'

  permit_params :name, :description, permission_ids: []

  index do
    id_column
    column :name
    column :description
    column :created_at
    column :updated_at
    actions
  end

  filter :name

  form do |f|
    f.inputs do
      f.input :name
      f.input :description
      f.input :permissions, :as => :check_boxes, :collection => Permission.order("subject_class ASC").all
    end
    f.actions
  end
end
