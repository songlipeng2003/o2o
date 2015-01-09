ActiveAdmin.register TradingRecord do
  actions :index, :show

  index do
    selectable_column
    id_column
    column :user
    column :type
    column :amount
    column :object
    column :created_at
    actions
  end

  filter :type
  filter :amount
  filter :created_at
end
