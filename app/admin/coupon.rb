ActiveAdmin.register Coupon do
  menu parent: '代金券'

  actions :index, :show

  index do
    id_column
    column :user
    column :system_coupon
    column :amount
    column :state do |coupon|
      coupon.aasm.human_state
    end
    column :created_at
    actions
  end

  filter :system_coupon
  filter :amount
  filter :state
  filter :created_at

end
