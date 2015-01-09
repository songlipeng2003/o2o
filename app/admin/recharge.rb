ActiveAdmin.register Recharge do
  actions :index, :show

  index do
    selectable_column
    id_column
    column :user
    column :amount
    column :state
    column :created_at
    actions
  end

  filter :amount
  filter :state
  filter :created_at
end
