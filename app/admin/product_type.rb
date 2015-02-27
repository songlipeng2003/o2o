ActiveAdmin.register ProductType do
  menu parent: '商品'

  config.batch_actions = false

  permit_params :name, :description

  index do
    id_column
    column :name
    column :description
    actions
  end

  filter :name
  filter :description

  form do |f|
    f.inputs do
      f.input :name
      f.input :description
    end
    f.actions
  end
end
