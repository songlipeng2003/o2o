ActiveAdmin.register Order do
  actions :index, :show

  scope :all, :default => true

  scope :unpayed do
    Order.where(state: :unpayed)
  end

  scope :payed do
    Order.where(state: :payed)
  end

  scope :finished do
    Order.where(state: :finished)
  end

  scope :closed do
    Order.where(state: :closed)
  end

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
