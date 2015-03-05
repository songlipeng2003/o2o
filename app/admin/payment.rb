ActiveAdmin.register Payment do
  menu parent: '财务'

  actions :index, :show, :edit, :update

  permit_params :name, :description, :pay_fee, :is_show

  config.batch_actions = false

  index do
    id_column
    column :name
    column :code
    column :pay_fee
    column :is_show
    column :created_at
    column :updated_at
    actions
  end

  filter :name
  filter :code

  form do |f|
    f.inputs do
      f.input :code, :input_html => { :readonly => true }
      f.input :name
      f.input :description
      f.input :pay_fee
      f.input :is_show
    end
    f.actions
  end
end
