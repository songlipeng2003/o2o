ActiveAdmin.register MonthCardOrder do
  menu parent: '订单'

  actions :index, :show

  scope '所有', :all, default: true

  scope :unpayed do |scope|
    scope.where(state: :unpayed)
  end

  scope :payed do |scope|
    scope.where(state: :payed)
  end

  scope :closed do |scope|
    scope.where(state: :closed)
  end

  index do
    selectable_column
    column :user
    column :car
    column :month
    column :price
    column :state do |order|
      order.aasm.human_state
    end
    column :application
    column :created_at
    actions
  end

  filter :month
  filter :price
  filter :state, as: :select, collection: MonthCardOrder.aasm.states
  filter :application
  filter :created_at
end
