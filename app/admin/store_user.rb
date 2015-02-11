ActiveAdmin.register StoreUser do
  belongs_to :store
  navigation_menu :store

  permit_params :email, :phone, :username, :password, :password_confirmation, :gender, :nickname

  index do
    selectable_column
    id_column
    column :username
    column :phone
    column :gender
    column :nickname
    column :current_sign_in_at
    column :sign_in_count
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
      f.input :email
      f.input :username
      f.input :phone
      f.input :password
      f.input :password_confirmation
      f.input :gender, collection: StoreUser::GENDERS
      f.input :nickname
    end
    f.actions
  end
end
