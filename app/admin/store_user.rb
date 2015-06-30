ActiveAdmin.register StoreUser do
  belongs_to :store
  navigation_menu :store

  permit_params :email, :phone, :username, :password, :password_confirmation, :gender, :nickname, :role, :avatar

  index do
    selectable_column
    id_column
    column :username
    column :avatar do |store_user|
      image_tag store_user.avatar.thumb if store_user.avatar
    end
    column :phone
    column :nickname
    column :role do |store_user|
      store_user.role_name
    end
    column :current_sign_in_at
    column :created_at
    actions
  end

  filter :email
  filter :phone
  filter :username
  filter :gender
  filter :nickname
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at

  form do |f|
    f.inputs do
      f.input :store
      f.input :avatar, :image_preview => true
      f.input :email
      f.input :username
      f.input :nickname
      f.input :phone
      f.input :role, as: :select, collection: StoreUser::ROLES.invert
      if f.object.new_record?
          f.input :password
          f.input :password_confirmation
      end
      f.input :gender, collection: StoreUser::GENDERS
    end
    f.actions
  end
end
