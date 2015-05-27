ActiveAdmin.register ServiceTicket do
  menu parent: '促销'

  actions :index, :show

  index do
    selectable_column
    id_column
    column :big_customer
    column :user
    column :code
    column :state do |recharge|
      recharge.aasm.human_state
    end
    column :created_at
    column :updated_at
    actions
  end

  filter :code
  filter :state, as: :select, collection: ServiceTicket.aasm.states
  filter :created_at
end
