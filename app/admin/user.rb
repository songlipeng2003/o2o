ActiveAdmin.register User do
  menu parent: '用户'

  actions :index, :show

  index do
    id_column
    column :phone
    column :nickname
    column :balance
    column :score
    column "代金券数量", :coupons do |user|
      user.coupons.count
    end
    column :current_sign_in_at
    column :created_at
    actions
  end

  filter :phone
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at

  show do
    attributes_table do
      row :id
      row :email
      row :sign_in_count
      row :current_sign_in_at
      row :last_sign_in_at
      row :current_sign_in_ip
      row :last_sign_in_ip
      row :phone
      row :score
      row :gender
      row :nickname
      row :avatar do |user|
        image_tag user.avatar.url if user.avatar.url
      end
      row :created_at
      row :updated_at
    end
  end
end
