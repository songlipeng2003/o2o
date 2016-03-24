ActiveAdmin.register PaymentLog do
  menu parent: '财务'

  actions :index, :show

  config.batch_actions = false

  scope :all, :default => true

  scope :unpayed do |scope|
    scope.where(state: :unpayed)
  end

  scope :payed do |scope|
    scope.where(state: :payed)
  end

  scope :closed do |scope|
    scope.where(state: :closed)
  end

  scope :refunded do |scope|
    scope.where(state: :refunded)
  end

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
