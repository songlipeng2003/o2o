ActiveAdmin.register WashMachine do
  menu parent: '基础数据'

  permit_params :code, :lat, :lon, :address, :price

  index do
    selectable_column
    id_column
    column :code
    column :address
    column :price
    column :created_at
    column :updated_at
    actions
  end

  filter :code
  filter :address
  filter :created_at
  filter :updated_at

  form do |f|
    f.inputs do
      f.input :code
      f.input :lon
      f.input :lat
      f.input :address
      f.input :price
    end
    f.actions
  end
end
