ActiveAdmin.register WashMachineSet do
  menu parent: '基础数据'

  permit_params :name, :price, :image, :description

  index do
    selectable_column
    id_column
    column :name
    column :price
    column :created_at
    column :updated_at
    actions
  end

  filter :name
  filter :price
  filter :created_at
  filter :updated_at

  form do |f|
    f.inputs do
      f.input :name
      f.input :price
      f.input :image, :image_preview => true
      f.input :description
    end
    f.actions
  end

  show do
    attributes_table do
      row :id
      row :name
      row :price
      row :image do
        image_tag(wash_machine_set.image.url)
      end
      row :description
    end
  end
end
