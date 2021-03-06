ActiveAdmin.register StoreUser do
  belongs_to :store
  navigation_menu :store

  permit_params :email, :phone, :username, :password, :password_confirmation, :gender, :nickname, :role, :avatar, :store_id

  index do
    selectable_column
    id_column
    column :username
    column :avatar do |store_user|
      if store_user.avatar.attached?
        image_tag(store_user.avatar, width: 300)
      end
    end
    column :phone
    column :nickname
    column :role do |store_user|
      store_user.role_name
    end
    column :current_sign_in_at
    column :created_at
    actions defaults: true do |store_user|
      link = ''
      link << link_to('修改密码', change_password_admin_store_store_user_path(store, store_user))

      raw link
    end
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
      f.input :avatar, as: :file
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

  member_action :change_password, method: [:get, :put, :patch] do
    @store_user = StoreUser::find(params[:id])

    if request.put? || request.patch?
      @store_user.password = params[:store_user][:password]
      @store_user.password_confirmation = params[:store_user][:password_confirmation]
      if @store_user.save
        redirect_to admin_store_store_user_path(@store_user.store, @store_user), notice: "修改密码成功"
      end
    end

    @page_title = "修改密码"
  end

  controller do
    def update
      super do |success,failure|
        success.html { redirect_to collection_path }
      end
    end
  end
end
