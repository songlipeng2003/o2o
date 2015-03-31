ActiveAdmin.register Finance do
  menu parent: '财务'

  actions :index

  config.batch_actions = false

  index do
    id_column
    column :financeable
    column :balance
    column :freeze_balance
    column :created_at
    column :updated_at
    actions
  end

  filter :balance
  filter :freeze_balance
  filter :created_at
  filter :updated_at
end
