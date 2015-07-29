ActiveAdmin.register ServiceTicketBatch do
  menu parent: '促销'

  actions :index, :show, :new, :create

  permit_params :big_customer_id, :number

  index do
    selectable_column
    id_column
    column :big_customer
    column :number
    column :used_count
    column :created_at
    actions
  end

  form do |f|
    f.inputs do
      f.input :big_customer
      f.input :number
    end
    f.actions
  end

  filter :number
  filter :used_count
  filter :created_at
end
