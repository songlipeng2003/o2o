ActiveAdmin.register PaymentLog do
  menu parent: '财务'

  actions :index, :show

  config.batch_actions = false

  index do
    id_column
    column :sn
    column :item
    column :payment
    column :state do |order|
      order.aasm.human_state
    end
    column :application
    column :created_at
    actions
  end
end
