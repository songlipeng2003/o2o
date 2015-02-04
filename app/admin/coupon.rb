ActiveAdmin.register Coupon do
  menu parent: '优惠券'

  actions :index, :show

  index do
    id_column
    column :user
    column :system_coupon
    column :amount
    column :state
    column :created_at
    actions
  end

  filter :system_coupon
  filter :amount
  filter :state
  filter :created_at

end
