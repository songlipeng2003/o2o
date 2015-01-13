ActiveAdmin.register Recharge do
  menu parent: '财务'

  actions :index, :show

  index do
    selectable_column
    id_column
    column :user
    column :amount
    column :recharge_policy
    column :state do |recharge|
      recharge.aasm.human_state
    end
    column :created_at
    column :payed_at
    actions
  end

  filter :amount
  filter :state
  filter :created_at
  filter :payed_at

  show do
    attributes_table do
      row :id
      row :user
      row :amount
      row :recharge_policy
      row :state do |recharge|
        recharge.aasm.human_state
      end
      row :created_at
      row :payed_at
    end
  end
end
