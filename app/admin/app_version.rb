ActiveAdmin.register AppVersion do

  permit_params :file, :version, :description

  index do
    selectable_column
    id_column
    column :file
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
