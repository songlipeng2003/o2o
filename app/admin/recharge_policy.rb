ActiveAdmin.register RechargePolicy do
  menu parent: '财务'

  permit_params :amount, :present_amount, :note

  index do
    selectable_column
    id_column
    column :amount
    column :present_amount
    column :created_at
    actions
  end

  filter :amount
  filter :present_amount
end
