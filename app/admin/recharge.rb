ActiveAdmin.register Recharge do
  actions :index, :show

  index do
    selectable_column
    id_column
    column :user
    column :amount
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
      row :state do |recharge|
        recharge.aasm.human_state
      end
      row :created_at
      row :payed_at
    end
  end
end
