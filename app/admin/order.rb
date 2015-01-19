ActiveAdmin.register Order do
  actions :index, :show

  index do
    selectable_column
    id_column
    column :user
    column :store
    column :car
    column :phone
    column :address
    column :booked_at
    column :state do |order|
      order.aasm.human_state
    end
    column :created_at
    actions
  end

  filter :phone
  filter :address
  filter :booked_at
  filter :created_at
end
