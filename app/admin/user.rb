ActiveAdmin.register User do
  menu parent: '用户'

  actions :index, :show

  index do
    selectable_column
    id_column
    column :phone
    column :nickname
    column :balance
    column :score
    column "代金券数量", :coupons do |user|
      user.coupons.count
    end
    column :current_sign_in_at
    column :sign_in_count
    column :created_at
    actions
  end

  filter :phone
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at
end
